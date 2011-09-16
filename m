Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8GF2E72023496
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 11:02:14 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8GF2DGq028313
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 15:02:13 GMT
Message-ID: <4E7364ED.2030504@redhat.com>
Date: Fri, 16 Sep 2011 11:02:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: dave w <nullcore@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] policycoreutils: preserve mode bits and ownership of
 /tmp in seunshare
References: <CAB04Hprsq9z4qYzO+pTOMYC41ma7d3J7+hrcQ04KSkOQnBEnBQ@mail.gmail.com>  <1316117256.2202.104.camel@vortex>  <CAB04Hpr23zFfegf2421-N22350p5arDZ9SjRB4pRjt2Bgx64tg@mail.gmail.com> <1316151755.2364.45.camel@vortex>
In-Reply-To: <1316151755.2364.45.camel@vortex>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/16/2011 01:42 AM, Guido Trentalancia wrote:
> Hello Dave, thanks for the explanation
> 
> On Thu, 2011-09-15 at 17:07 -0400, dave w wrote:
>> On Thu, Sep 15, 2011 at 4:07 PM, Guido Trentalancia 
>> <guido@trentalancia.com> wrote:
>>> Hello Dave.
>>> 
>>> On Thu, 2011-09-15 at 13:39 -0400, dave w wrote:
>>>> Hi,
>>>> 
>>>> This patch addresses a flaw in seunshare.c that allows
>>>> unprivileged users to arbitrarily modify the contents of
>>>> /tmp.  This bug is further described in CVE 2011-1011 
>>>> (http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2011-1011):
>>>
>>>
>>>> 
seunshare should not be installed by default and, even if it still
>>> needed to be installed by default, its setuid bit should be
>>> carefully re-evaluated in my opinion.
>>> 
>> 
>> Perhaps, but distros that install seunshare at present will be
>> made safer with the addition of a patch which eliminates an
>> attack vector to a privilege escalation.
> 
> So the question now is: CVE-2011-1011 is dated 20110214, how comes
> this is trying to get sorted out only now for upstream ?
> 
>>> In any case, good practice says nothing should ever be allowed
>>> to mount under /tmp with suid/exec flags (use noexec,nosuid
>>> options in fstab).
>>> 
>>> That said, have you tested the patch already ? Is it effective
>>> ?
>>> 
>> 
>> Yes, the patch has been effective and with it applied,
>> unprivileged users cannot delete files other than their own from
>> /tmp, which is the expected behavior in a directory with the
>> sticky bit set owned by the superuser.
>> 
>>> Thanks.
>>> 
>>> Guido
>>> 
>>>> The seunshare_mount function in sandbox/seunshare.c in
>>>> seunshare in certain Red Hat packages of policycoreutils
>>>> 2.0.83 and earlier in Red Hat Enterprise Linux (RHEL) 6 and
>>>> earlier, and Fedora 14 and earlier, mounts a new directory on
>>>> top of /tmp without assigning root ownership and the sticky
>>>> bit to this new directory, which allows local users to
>>>> replace or delete arbitrary /tmp files, and consequently
>>>> cause a denial of service or possibly gain privileges, by
>>>> running a setuid application that relies on /tmp, as
>>>> demonstrated by the ksu application
> 
> What happened exactly for upstream since the CVE was initially 
> released ?
> 
>>>> This patch preserves the mode bits, and thus permissions,
>>>> and ownership of the destination directory of the bind mount
>>>> performed by seunshare.  The permission check in
>>>> verify_mount() was relaxed for directories who originally had
>>>> the sticky bit set, as root ownership is required for these
>>>> to ensure that unprivileged users cannot unlink arbitrary
>>>> files in the newly bind mounted directory.
> 
> Is it the first time ever that you post a patch to try sorting out
> the same issue ?
> 
>>>> Thanks, David
> 
> Thanks, Guido.
> 
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 

We fixed it in Fedora and RHEL and either we dropped the ball or
upstream did on getting the fix into the upstream policy.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5zZO0ACgkQrlYvE4MpobPnNgCbBygZIFPkggN4ybPIdBxMNvNN
WsgAnjfLv+1VekZqP4HBv19lHXIUz1Z+
=w6H4
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
