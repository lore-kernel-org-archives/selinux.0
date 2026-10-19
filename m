Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B93527FCC
	for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418578; cv=none; b=JuzAriuqxVrbUXL8r7VEr0enEJMNGacLLr4vUoihUDyn9nq3fVGAPr1ga0yM9RiPjX5kkWdKE5OznHbLk4Wz/uqBh0Rt5hd3MxW+ycDgnEKQ+kXea8MeAPnLHXKCMt0qprtnCIJHr4HXjx5n9LpEE4XKDp5H8weXKY+1q1GFRdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418578; c=relaxed/simple;
	bh=OEjKswn7X3i/WkLZMuipCuLKp6NB2OxlyQJ5g4/czXQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=YiOpkA2SYWFs9RIOJDYKmvV7mSl+fKjq3xP2vMszMQd5VOGVgzoqPuEP0Zxo1ucED1XmTXLeiLBmxmMk318bGK+24AqJRV1nkyySUolpvlgsLGYxfdMpDRTi9zEK2epItve8OHJ1+DM83WTpaJxj/W4phO28v3YCe8L8plfIKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h6YWdYhd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h6YWdYhd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0HZEK/m8OC7MxpwiSP0OQkeOTb6dIE0Nk7VB0C2JoLU=; b=h6YWdYhdATyxTdBB7QMFNCLfym
	a7u4g+E4QsfQ26sScQKgkS7/rV1248VSJkSrjwGuO8S82jwaRTfK3Tm7Kp0RnFt1bSRk8V9KIweKL
	ok7yx7TxNxCj3pz6tYTZKqzEML+/fDkayVU69uO1CBw5IezNKWEhm1KUzs9rLrsc7rq3DGjt9QZjP
	cMoQbcwZZ8hFwUQXF1tMw594vz+a2jdONZ8RSMtpvGPZAmTJFlaYQQEHv3H9iBUyo/IOw8vpt61bI
	C1nRHwtNhSkLJxKVu6M3zKm0cXHGSB2D96zagKpkNaoCrMJZXmYTZDsnWFcq/XAPlMRnA7oYtBryG
	ePMCRXIg==;
Received: from 54-240-197-233.amazon.com ([54.240.197.233] helo=edge-m3-r2-116.e-iad51.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xInww-00000008lO5-1L7k;
	Mon, 19 Oct 2026 14:02:50 +0000
Message-ID: <71419b5cb9dc6c289ac7a64b9fe44a3b29bb5d56.camel@infradead.org>
Subject: [PATCH] tests/tun_tap: set an owner on the device for the relabel
 tests
From: David Woodhouse <dwmw2@infradead.org>
To: selinux@vger.kernel.org
Cc: Andrew Lutomirski <luto@kernel.org>, Willem de Bruijn
 <willemb@google.com>,  Jakub Kicinski	 <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>, Ondrej Mosnacek
 <omosnace@redhat.com>
Date: Mon, 19 Oct 2026 15:02:48 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-hytwzv9Wb4mAOByVwcX7"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-hytwzv9Wb4mAOByVwcX7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

tun_relabel creates a persistent tun device with neither an owner nor
a group, then reattaches to it from a new context without
CAP_NET_ADMIN, exercising the tun_socket { relabelfrom relabelto }
checks. That reattach only works because the kernel permits anyone at
all to attach to an ownerless device.

Kernel commit 3ca459eaba1b ("tun: fix group permission check") made
such an attach require CAP_NET_ADMIN, and all six relabel tests failed
with EPERM from the kernel's capability check before the LSM hooks
were reached. That commit was reverted in a70c7b3cbc06 ("tun: revert
fix group permission check"), but these tests should not depend on
which way the kernel resolves that question.

Set an owner on the device before making it persistent. The reattach
is then permitted by the kernel's owner check either way, with no
capability required, and control reaches the LSM relabel checks that
these tests exist to exercise.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tests/tun_tap/tun_common.c  | 16 ++++++++++++++++
 tests/tun_tap/tun_common.h  |  2 ++
 tests/tun_tap/tun_relabel.c | 12 ++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/tests/tun_tap/tun_common.c b/tests/tun_tap/tun_common.c
index 86e41df..282509a 100644
--- a/tests/tun_tap/tun_common.c
+++ b/tests/tun_tap/tun_common.c
@@ -50,6 +50,22 @@ int persist(int fd, int op, char *name, bool verbose)
 	return 0;
 }
=20
+int set_owner(int fd, uid_t owner, bool verbose)
+{
+	int result;
+
+	result =3D ioctl(fd, TUNSETOWNER, owner);
+	if (result < 0) {
+		fprintf(stderr, "Failed ioctl(TUNSETOWNER): %s\n",
+			strerror(errno));
+		return errno;
+	}
+	if (verbose)
+		printf("ioctl(TUNSETOWNER) uid: %u\n", owner);
+
+	return 0;
+}
+
 int tunsetqueue(int fd, int op, char *name, bool verbose)
 {
 	int result;
diff --git a/tests/tun_tap/tun_common.h b/tests/tun_tap/tun_common.h
index 6a3a604..a8e237b 100644
--- a/tests/tun_tap/tun_common.h
+++ b/tests/tun_tap/tun_common.h
@@ -16,6 +16,8 @@ extern int open_dev(int *fd, char *test_str, bool verbose=
);
 extern int setiff(int fd, struct ifreq *ifr, bool verbose);
 /* Persistent state 'op': 0 =3D unset, 1 =3D set */
 extern int persist(int fd, int op, char *name, bool verbose);
+/* Set the device owner to the given uid */
+extern int set_owner(int fd, uid_t owner, bool verbose);
 /* Queue state 'op': 0 =3D IFF_DETACH_QUEUE, 1 =3D IFF_ATTACH_QUEUE */
 extern int tunsetqueue(int fd, int op, char *name, bool verbose);
 extern int switch_context(const char *newcon, bool verbose);
diff --git a/tests/tun_tap/tun_relabel.c b/tests/tun_tap/tun_relabel.c
index f4e6771..e7fad50 100644
--- a/tests/tun_tap/tun_relabel.c
+++ b/tests/tun_tap/tun_relabel.c
@@ -86,6 +86,18 @@ int main(int argc, char *argv[])
=20
 	strcpy(alloc_name, ifr.ifr_name);
=20
+	/*
+	 * Set an owner, so that reattaching from the new context relies
+	 * only on the tun_socket relabel permissions under test, and not
+	 * on the kernel allowing anyone to attach to a persistent device
+	 * with neither owner nor group set (which kernel commit
+	 * 3ca459eaba1b ("tun: fix group permission check") stopped
+	 * allowing, until it was reverted).
+	 */
+	result =3D set_owner(fd1, getuid(), verbose);
+	if (result !=3D 0)
+		goto err1;
+
 	/* Make this name persist */
 	result =3D persist(fd1, 1, alloc_name, verbose);
 	if (result !=3D 0)
--=20
2.43.0


--=-hytwzv9Wb4mAOByVwcX7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
xHVCs/54/t77IsD1lE3hgNoAAAAAAAA=


--=-hytwzv9Wb4mAOByVwcX7--
