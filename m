Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7QCxVmn011432
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2011 08:59:31 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7QCxT7u007412
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2011 12:59:29 GMT
Message-ID: <4E5798AD.5080908@redhat.com>
Date: Fri, 26 Aug 2011 08:59:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: qingtao.cao@windriver.com, Eric Paris <eparis@parisplace.org>,
        cpebenito@tresys.com, slawrence@tresys.com, selinux@tycho.nsa.gov
Subject: Re: v0 Separate tunables from booleans
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <CACLa4pvMmx32JpX=vzOb8TvEqJ7HqTBVK=PNTFQjkiF924sMjA@mail.gmail.com> <4E55E8E7.1050804@windriver.com> <4E564860.2090502@redhat.com> <4E56F435.1080608@windriver.com> <4E57036F.4070900@redhat.com>
In-Reply-To: <4E57036F.4070900@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/25/2011 10:22 PM, Eric Paris wrote:
> On 08/25/2011 09:17 PM, Harry Ciao wrote:
>> Daniel J Walsh 写道:
> 
>>> The Fedora policy has removed all calls that do stuff like
>>> 
>>> allow XYZ_t { file_type -shadow_t }:file read;
>>> 
>>> Which generates hundreds/thousands of rules when run though the
>>> M4 Macro, since it writes a rule for each file_type except the
>>> shadow_t. Anywhere in policy that we use this construct has to
>>> be reworked and this shrunk the policy by 90%.  Your
>>> enhancement just adds another 5% reduction after this change.
>>> I sent a patch to refpolicy yesterday to fix the coreutils
>>> interfaces that we doing something like this.
>>> 
>>> 
>>> 
>> I don't know much about Fedora policy, but for upstream refpolicy
>> and toolchain my patch would contribute 45% size reduction for
>> raw policy and before I sent my patchset out for review I had not
>> seen your patch.
>> 
>> Anyway, it would be fantastic to have your patch to further
>> drastically reduce the raw policy size, the whole community would
>> benefit from each single contributor's effort like this.
> 
> Agreed.  I'm excited about both approaches (reducing the policy
> size by using attributes and eliminating needless unused portions
> of booleans). I'm glad to see Dan pushing his changes.  Once this
> patch set is finished I'll be very happy to see a further 5-6%
> reduction in the policy size of Fedora!
> 
> -Eric
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 


I agree, I would like to take the patch to make tunables real, but we
need to have a similar level of diagnosis capability to what we have now.

The admin needs to know what the tunables are and needs to be able to
take an AVC and see if any tunable/boolean would allow the AVC.

If we had this, I would be racing towards the tunable.

I see this as two steps.

1.  Implement what we have now in booleans in tunables to shrink the
size of policy.
2.  Allow policy writers to define rules within tunables that is
currently not available in booleans.
    - Type Definitions
    - Assigning attributes

The major problems with #2 is I am not sure we have good tools to
analyze this type of policy from the audit2allow -> tunable that I
talk about above, to the security analysis that DOD needs.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5XmKkACgkQrlYvE4MpobM0VACeNKcVtb597WkpThQ+hnLbC6M+
cTcAniR5MBqUGm0AUndTSrwNfbkATN1q
=DroM
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
