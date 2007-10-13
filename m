Message-ID: <4710CA44.1040300@redhat.com>
Date: Sat, 13 Oct 2007 09:38:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: concept of a permissive domain
References: <C3357D99.2F091%csellers@tresys.com>
In-Reply-To: <C3357D99.2F091%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Chad Sellers wrote:
> On 10/12/07 5:21 PM, "Karl MacMillan" <kmacmillan@mentalrootkit.com> wrote:
> 
>> On Fri, 2007-10-12 at 16:43 -0400, Chad Sellers wrote:
>>> On 10/12/07 3:05 PM, "Karl MacMillan" <kmacmillan@mentalrootkit.com> wrote:
>>>
>>>> On Fri, 2007-10-12 at 14:40 -0400, Chad Sellers wrote:
>> [...[
>>
>>>> Calling it a permissive domain uses the same concept as global
>>>> permissive - so I think that is natural. It does not, to me, mean that
>>>> it should be enabled in the same way as global permissive - that's just
>>>> an implementation detail. I think it is much better to put it in the
>>>> policy as that allows some sort of sane delivery mechanism.
>>>>
>>> Calling it one thing and implementing it differently is fine as long as the
>>> implementation doesn't leak out to the user. And it will here. We're not
>>> exactly good at making leak-proof abstractions to begin with, but this is a
>>> case where the user will see a new statement in policy.
>>>
>>> Think of this from the perspective of the user. We have to tell them that
>>> system-wide permissive is not part of policy, but is instead in a config
>>> file, done using setenforce, or done using selinuxfs, but per-domain
>>> permissive is not done by any of those methods, but instead is done in
>>> policy via a new language construct. This is confusing.
>>>
>>> Chad
>> See, now you are going to make me argue for putting permissive in the
>> policy, which I think that it should be. The fact that we have
>> permissive in a separate config file, have to write a little parser in
>> libselinux, patch apps to set permissive on boot is just dumb.
>>
> I figured that might be your response. I actually don't mind that solution
> at all. I'm just trying to minimize the number of different concepts in
> SELinux.
> 
>> That doesn't mean when shouldn't allow small changes to the in-kernel
>> policy - like switching permissive on or off - but I still think it
>> makes no sense to have one big configuration file with lots of tiny
>> supporting config files. Just put it all in one place and be done with
>> it.
>>
> Note that we already have a mechanism for turning pieces of policy on/off
> in-kernel (booleans). So, if permissive were policy based, we could
> potentially simplify things by having the kernel "switch" be just another
> boolean instead of a separate mechanism.
> 
> Chad
> 
>> Karl
>>
> 
- From the user point of view we could change the setenforce command

setenforce 0
setenforce httpd_t 0

getenforce 0
getenforce httpd_t 0

Then we could replace both to do something in semanage to rebuild and
reload policy.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHEMpErlYvE4MpobMRApyIAKDPblk4zBoGsZyj8euc1JgTpvetcACgmpNI
4zKVHCrPKOGtuFPnm35xM5c=
=n6n2
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
