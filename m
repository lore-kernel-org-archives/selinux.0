Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6CFwx47024073
 for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2016 11:59:01 -0400
From: Todd Rinaldo <toddr@cpanel.net>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0D8FE5EF-3213-4DD6-9F07-B107B6E4190C";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Date: Tue, 12 Jul 2016 10:58:56 -0500
Subject: Inconsistent RSS on Red Hat 7 but not 6.
To: selinux@tycho.nsa.gov
Message-Id: <D13ED7AE-0CB2-4D6B-8BB2-6C78F16FB46B@cpanel.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>


--Apple-Mail=_0D8FE5EF-3213-4DD6-9F07-B107B6E4190C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

We keep metrics on our binaries with respect to how much memory they =
take up at startup time. So for instance if you run ./a.pl --basemem, it =
grabs the VmRSS value out of /proc/$$/status and exits.

When we added Red Hat 7 support to our product, we noticed that this =
value was VERY unstable. After much poking, I accidentally discovered =
that this was a side effect of having selinux enabled when doing the =
check.

When I disable selinux in /etc/selinux/config and reboot, I found that =
./a.pl --basemem became much more stable.

I am guessing something changed between Red Hat 6 and 7 which caused =
libselinux to map differently into the address space. I'm however not =
ruling out a libc change. Can anyone shed light on this or point me to =
something that would indicate why? For reference, this is libselinux =
2.2.2 vs 2.0.94.

Thanks,
Todd Rinaldo


--Apple-Mail=_0D8FE5EF-3213-4DD6-9F07-B107B6E4190C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXhRPAAAoJEBNP/Wq+e4WNrSgP/0bNByYXdg5saeOk3wuRvX1w
mgUz4uIC8X+4VL4CAb8P7UbjzLGdvLj/IWZK+0d5FeyO6FGUDpus+s2HtAIhtEG4
WJqPPD9Qmovz/hYFHrWaXyGtDBAUNDB0nwWH2svgwbTfCHNncxWXUaf9VfMgGD1Z
uEIZ4nu9Jo5ls5m5ePhyGPhjY7FDS7UiOXF5rHjxvk5pj9Z734DZZsAWQvuJeydO
0iFsNxLKLWm0W7fTpLuAMN4FSFlBOnBk62sW1c4AT8djVSEswdMrPhRCfxgTwPyx
Fx/wEbb2Q6SDCXh8Lvg6av96sMrn70gnc5NOchneNzjC1jyEvt3LoXcGyb5REZsq
srOc1vfSkOU5k4ac0zHfZ4SV/hgf4KYoDazVY7FqcM6M0fCN3+PX1HVLf7rF5iRL
GvlCBJ683E5Db6Y8XBhqPzE4zYaXwqay6DjwGvk1y3cLQwvAL5ZDm98rjHDgB8Aw
uEjplYGBgIFfTdT0nJiKLcbhMaN3SvqNtRUL6YQZ/OaQrOcxCV+Nvjj57Ptdri9L
+yN3XjbecdWAIr4OICwcIHsXlqp9rLP4wjF0fRe6zT7XLgmgG0q7RSNJR1Eq8HnY
wBLwafZj4E7C3RkoquzLq8RRsmgwKve0gH00Hn8P6SgAS98KHX2EHzsY0cyD3WDF
EmbR1+8r0FIc5uZbLq+L
=CT57
-----END PGP SIGNATURE-----

--Apple-Mail=_0D8FE5EF-3213-4DD6-9F07-B107B6E4190C--
