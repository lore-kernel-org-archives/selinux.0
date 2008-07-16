Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GFSN04023626
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 11:28:23 -0400
Received: from sender-02.it.helsinki.fi (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GFSMXE005257
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 15:28:22 GMT
Received: from ruuvi.it.helsinki.fi (ruuvi.it.helsinki.fi [128.214.205.65])
	by sender-02.it.helsinki.fi (8.13.8/8.13.8) with ESMTP id m6GFSLtA030207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 18:28:21 +0300
Received: from ruuvi.it.helsinki.fi (localhost.localdomain [127.0.0.1])
	by ruuvi.it.helsinki.fi (8.13.1/8.13.1) with ESMTP id m6GFSLfr012314
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 18:28:21 +0300
Received: from localhost (vmkari@localhost)
	by ruuvi.it.helsinki.fi (8.13.1/8.13.1/Submit) with ESMTP id m6GFSLsA012311
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 18:28:21 +0300
Date: Wed, 16 Jul 2008 18:28:21 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: selinux@tycho.nsa.gov
Subject: Buggy patch (Re: Proposed patch for policycoreutils/sestatus)
In-Reply-To: <Pine.LNX.4.64L.0807161749060.10705@ruuvi.it.helsinki.fi>
Message-ID: <Pine.LNX.4.64L.0807161817520.12245@ruuvi.it.helsinki.fi>
References: <Pine.LNX.4.64L.0807161749060.10705@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696237619-739464853-1216222101=:12245"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696237619-739464853-1216222101=:12245
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hello,

On Wed, 16 Jul 2008, Vesa-Matti J Kari wrote:

> I hope I didn't break anything, so if you have the time, please check out
> the code and test it too. Yes, the program is trivial, but some errors
> may have crept in nevertheless...

I am very sorry for being hasty with sending the patch.

My sestatus.diff indeed contains a bug that makes double free() possible.

If strdup() fails to allocate memory, then load_checks() free():s all
the memory allocated so far, but it does not reset *npc and *nfc to zero.

Hence proccon_show() and filecon_show() might free() the memory that
has already been free():d by load_checks().

The fix patch is attached.

Apologies again.

Best regards,
vmk
--
************************************************************************
               Tietotekniikkaosasto / Helsingin yliopisto
                 IT Department / University of Helsinki
************************************************************************
---696237619-739464853-1216222101=:12245
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=sestatus2.diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64L.0807161828210.12245@ruuvi.it.helsinki.fi>
Content-Description: fix to prevent double free():ing
Content-Disposition: attachment; filename=sestatus2.diff

LS0tIHNlc3RhdHVzLmMub2xkCTIwMDgtMDctMTYgMTY6MjA6NTYuMDAwMDAw
MDAwICswMzAwDQorKysgc2VzdGF0dXMuYwkyMDA4LTA3LTE2IDE4OjEwOjUy
LjAwMDAwMDAwMCArMDMwMA0KQEAgLTE2NCw2ICsxNjQsNyBAQA0KIAkJZnJl
ZShwY1tpXSk7DQogCWZvciAoaSA9IDA7IGkgPCAqbmZjICYmIGkgPCBNQVhf
Q0hFQ0s7IGkrKykNCiAJCWZyZWUoZmNbaV0pOw0KKwkqbnBjID0gKm5mYyA9
IDA7DQogCWdvdG8gb3V0Ow0KIH0NCiANCg==

---696237619-739464853-1216222101=:12245--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
