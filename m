Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6MGr9Ll003571
 for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2015 12:53:09 -0400
Received: by igbij6 with SMTP id ij6so141794195igb.1
 for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2015 09:53:08 -0700 (PDT)
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
To: "J. Bruce Fields" <bfields@fieldses.org>,
 Dave Chinner <david@fromorbit.com>
References: <87vbdlf7vo.fsf@x220.int.ebiederm.org>
 <55A6E107.3070200@schaufler-ca.com>
 <CALCETrVCNQPVr-hg_pqd2J_LeWtRJs3LRsbbE+fifo4sat+FQQ@mail.gmail.com>
 <55A71CE3.4050708@schaufler-ca.com> <87fv4owvxv.fsf@x220.int.ebiederm.org>
 <20150717000914.GO7943@dastard> <87380nobs4.fsf@x220.int.ebiederm.org>
 <20150717024735.GW3902@dastard> <20150721173721.GE11050@fieldses.org>
 <20150722075640.GE7943@dastard> <20150722140923.GD22718@fieldses.org>
From: Austin S Hemmelgarn <ahferroin7@gmail.com>
Message-ID: <55AFCA6A.60304@gmail.com>
Date: Wed, 22 Jul 2015 12:52:58 -0400
MIME-Version: 1.0
In-Reply-To: <20150722140923.GD22718@fieldses.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-512; boundary="------------ms030001040205090200010008"
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a cryptographically signed message in MIME format.

--------------ms030001040205090200010008
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2015-07-22 10:09, J. Bruce Fields wrote:
> On Wed, Jul 22, 2015 at 05:56:40PM +1000, Dave Chinner wrote:
>> On Tue, Jul 21, 2015 at 01:37:21PM -0400, J. Bruce Fields wrote:
>>> On Fri, Jul 17, 2015 at 12:47:35PM +1000, Dave Chinner wrote:
>>> So, for example, a screwed up on-disk directory structure shouldn't
>>> result in creating a cycle in the dcache and then deadlocking.
>>
>> Therein lies the problem: how do you detect such structural defects
>> without doing a full structure validation?
>
> You can prevent cycles in a graph if you can prevent adding an edge
> which would be part of a cycle.
>
Except if the user can write to the filesystem's backing storage (be it=20
a device or a file), and has sufficient knowledge of the on-disk=20
structures, they can create all the cycles they want in the metadata.=20
So unless the kernel builds the graph internally by parsing the metadata =

_and_ has some way to detect that the on-disk metadata has hit a cycle=20
(which may not just involve 2 items), then you still have the potential=20
for a DoS attack.

Trust me, I've done this before (quite a while back when I was just=20
starting out with programming on Linux) with hard-link cycles in an ext4 =

filesystem in a virtual machine just to see what would happen (IIRC,=20
something deadlocked, I can't remember though if it was fsck or trying=20
to access the file once the FS was mounted) (and in fact, I think I may=20
try this again just to see if anything has changed).


--------------ms030001040205090200010008
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
cnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcN
AQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxBuVTANBglghkgBZQMEAgMFAKCCAiEwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTUwNzIyMTY1MjU4WjBPBgkq
hkiG9w0BCQQxQgRAYxrt4verCRKgcCqqn0qmr8YzdNn5idFbbn0BqhK6u8Fuqa5jGSOymLYA
a1x14j3OjRRXlyyqLwf60XDE/mlA7jBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAweTEQMA4GA1UE
ChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlD
QSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2Vy
dC5vcmcCAxBuVTCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMHUm9vdCBDQTEe
MBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25p
bmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxBuVTAN
BgkqhkiG9w0BAQEFAASCAgCGxeARXgflbSZcZNQcK6XCZsA1AJYo/Dpi6XhS2c66ClgmNk+2
k5DOqXhGa4wGNS2FJNvphVV8BXM6nWaJStulIIC9tbq7RMcqL7Z9Q3hqRVygu+9TYTZePZR4
+ZxRtiD5IbjnRCpskTBVxgCb6Wg5UAeDpJfUjeX6ydhqW6FX4KRNCAyrxU6V92rTewuAMP6o
Wg4LwdWWu0p0jkY8yWniXrM/7VFNd48wSOut/NBssF+t4f3FeKBBkA16OmGvb0HJRpCCE6YX
8we84BOlUWZ3/JJNYG/EnFlvC0jDJ1xpcNQZSbhyESfPuTHn4XxCGQAiQOTcjs7wmLL1PIrE
U5c1e1AVxxamBD43QJ+84bBuo9gBnbcIYSb77gtY5gWYfF3a+Gt9SoqC68+3IsIKC+ECpiay
6piM9CocKlYU31uY0PBrw9gMyzRsLOdImZTkYibkq24PV7psLWVRQLwU8EOafPSN+palgzg9
ilOHU93eZLaI1/avL84aa44+L3CVCoRNYz+5OWPW6F8joSi5fURoEBlsn52MrpTPNpCBJdSo
8H1JhoHVF6z4QzgnG8hASvxUwQkcqnJLhRyzy3CxOsUPGC825URWjPiYpfz0uVcryRvU2QZL
Dpq07CdYlN7efdH6zWdKeG9tp6xePTwt0HWr6wogaMYXrVWqKVe0j9wUYAAAAAAAAA==
--------------ms030001040205090200010008--
