Message-ID: <527D677B.7040305@redhat.com>
Date: Fri, 08 Nov 2013 17:36:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 08/08] Add message to tell user to install sandbox policy
 package.
References: <1383916655-9354-1-git-send-email-dwalsh@redhat.com> <1383916655-9354-9-git-send-email-dwalsh@redhat.com> <527D532A.8080209@tycho.nsa.gov>
In-Reply-To: <527D532A.8080209@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/08/2013 04:10 PM, Stephen Smalley wrote:
> On 11/08/2013 08:17 AM, Dan Walsh wrote:
>> Sandbox policy is huge do to macro expansion.  We do not install this by
>> default but sandbox command can fail without it installed.  This patch
>> prints a message to the user to install the package.
>> 
>> Signed-off-by: Dan Walsh <dwalsh@redhat.com>
> 
> Thanks, applied to #next.  Did not receive patch 06/08. patch 01/08 looked
> like a bug fix that should get pushed as an update, yes?
> 
> 
Yes.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJ9Z3sACgkQrlYvE4MpobNUlQCgrCVMPpmgZbd53nIogRXYgf9D
i/wAnjVV9AK2RRtJ+XF4ECw6RjH8ukVe
=R2Le
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
