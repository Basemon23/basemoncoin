#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Bitcoin Core Developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BITCOIND=${BITCOIND:-$BINDIR/basemoncoind}
BITCOINCLI=${BITCOINCLI:-$BINDIR/basemoncoin-cli}
BITCOINTX=${BITCOINTX:-$BINDIR/basemoncoin-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/basemoncoin-wallet}
BITCOINQT=${BITCOINQT:-$BINDIR/qt/basemoncoin-qt}

[ ! -x $BITCOIND ] && echo "$BITCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a BASEVER <<< "$($BITCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for basemoncoind if --version-string is not set,
# but has different outcomes for basemoncoin-qt and basemoncoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$BITCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $BITCOIND $BITCOINCLI $BITCOINTX $WALLET_TOOL $BITCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BASEVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BASEVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
