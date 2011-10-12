Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9CEF7af015589
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 10:15:07 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p9CEF5MM022347
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 14:15:06 GMT
Message-ID: <4E95A0E6.9070301@redhat.com>
Date: Wed, 12 Oct 2011 10:15:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: I am working to further shrink the size of policy in Fedora 17.
References: <4E8F43CE.7010605@redhat.com> <4E9598C0.9080700@tresys.com>
In-Reply-To: <4E9598C0.9080700@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/12/2011 09:40 AM, Christopher J. PeBenito wrote:
> On 10/07/11 14:24, Daniel J Walsh wrote:
>> Right now, every domain that transitions to another domain gets
>> the following rule written.
>> 
>> dontaudit SOURCE TARGET : process { noatsecure siginh rlimitinh }
>> ;
>> 
>> In Fedora 17 policy right now we have 2152 rules, out of
>> Dontaudit: 9415
>> 
>> 
>> sesearch --dontaudit -p noatsecure | wc -l 2152
>> 
>> We could rewrite this with one rule.
>> 
>> dontaudit domain domain:process { noatsecure siginh rlimitinh }
>> ;
>> 
>> Of course this is more lenient then what we have now, although
>> since it is dontaudit rules, not sure it matters.
>> 
>> Comments?
> 
> I'm on the fence.  On one hand, I hate to overspecify the policy,
> but on the other hand, these perms can only be hit on a domain
> transition.  How much does this save?
> 

2000/90000

2% of the size of policy.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6VoOYACgkQrlYvE4MpobP1owCfTdsEIG7MMy4PyOt05FfeANYx
U6UAmgKEgYIoER1S9qa7Ev3hxPH/73H4
=+vp+
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
