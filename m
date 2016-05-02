Subject: Re: userspace object managers get confused if an update changes
 object classes and access vectors
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 Lukas Vrabec <lvrabec@redhat.com>, Miroslav Grepl <mgrepl@redhat.com>,
 Daniel J Walsh <dwalsh@redhat.com>, Paul Moore <paul@paul-moore.com>
References: <d7fef34c-0b38-63f3-4a37-464930a03806@gmail.com>
 <385dc3db-6bfc-9724-0a51-6fe8530bd292@tycho.nsa.gov>
 <8c37e15e-67c2-5310-6522-bca44805bced@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <3933c88d-2eaa-8fd6-3fb5-fa61bd98982b@gmail.com>
Date: Mon, 2 May 2016 15:18:03 +0200
MIME-Version: 1.0
In-Reply-To: <8c37e15e-67c2-5310-6522-bca44805bced@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 05/02/2016 03:14 PM, Stephen Smalley wrote:
> On 04/29/2016 03:53 PM, Stephen Smalley wrote:
>> On 04/29/2016 01:04 PM, Dominick Grift wrote:
>>> 
>>> I have mentioned this before (probably a few times), and i am
>>> not sure if this issue is actually what i think it is but i
>>> will once again mention this issue i observed many times.
>>> 
>>> Excuse me if i am wrong here.
>>> 
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1331668
>>> 
>>> https://github.com/fedora-selinux/selinux-policy/commit/971e97a2b8cb
cc14
>>>
>>> 
3fc82badfaaf7900b4760399
>>> 
>>> When you change (user space?) access vectors then user space
>>> object managers get confused and stop working. This is now
>>> becoming an issue since core components are object managers
>>> (systemd/dbus)
>>> 
>>> So basically there is no way for distributions to add/remove
>>> access vectors without breaking the running system.
>>> 
>>> The only solution is immediately switch to permissive mode and
>>> to reboot the system after such an update. And you might not
>>> even be able to cleanly shutdown due to these confused
>>> components
>> 
>> (cc'd redhat folks so they can provide more context on what the
>> actual bug/issue was, since it wasn't entirely clear to me from
>> the bugzilla or commit above)
>> 
>> In general, the safest approach is to only add permissions at the
>> end of an existing class or add new classes at the end of the
>> current list of classes.  That avoids perturbing the values of
>> any existing permission or class and thus shouldn't cause any
>> breakage.  It looks like the commit you referenced was
>> adding/removing permissions at the end of the class though, so
>> I'm not clear on what broke there. There is something very odd
>> there though - I don't understand how Fedora policy got into a 
>> state where those permissions weren't defined in the first place,
>> or why they are inconsistent in their order with upstream
>> refpolicy.
> 
> I looked a bit more closely at this bug, and it appears to me that
> the issue was simply that they added definitions for start and
> stop _without_ allowing those permissions for any confined domains
> that needed them.  So then SELinux correctly denied those
> permissions and the system stopped working.  That's operating as
> intended, not a bug in SELinux or anything to do with the potential
> race in class/permission lookup and policy reload.
> 

Strange that then the solution seems to be removing the av perms again
instead of adding the required rules.

noneless, you've said it yourself (maybe not in so many words) that
the userspace object manager functionality is fragile in the sense
that object managers are not "fully safe against arbitrary changes to
class/permission definitions at runtime"

>> The fact that userspace code is using the system class at all is
>> a bug that has previously been pointed out; userspace needs to
>> use its own classes and not share one with the kernel.  The
>> kernel recently took another permission from that class, so there
>> is a conflict looming.
>> 
>> For userspace, selinux commit
>> b408d72ca9104cb0c1bc4e154d8732cc7c0a9190 was intended to help
>> with these kinds of changes, but as noted in the commit
>> description, there is still the potential interleaving of a 
>> policy reload and a call to selinux_check_access() that could
>> cause problems.
>> 
>> The kernel is presently the only component fully safe against
>> arbitrary changes to class/permission definitions at runtime, and
>> that is because it can atomically update its class/permission
>> mappings with the policy reload transaction.  I think making
>> userspace fully safe would require introducing a new selinuxfs
>> interface (e.g. /sys/fs/selinux/access2) that takes and returns
>> class and permission strings rather than values, so that the
>> kernel can internally handle the mapping and ensure it is updated
>> atomic with policy reloads too.  And one would then need to 
>> rework the userspace AVC and selinux_check_access() to use that 
>> interface, and convert any remaining userspace components that
>> are still using something other than selinux_check_access() for
>> SELinux permission checking.
> 


- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXJ1OHAAoJECV0jlU3+UdpsSEMAKPjyeVVi/1MPLuQtlleuulY
a1/BV17GsVSEMTwYwqJjY1oRZ0XoHvqMgzu0Yy8VHIQxkRS9y1EMHPLc1zEd/rF2
m80LjrU9Hw/EcIeWWJYk+lxTVErAg4WPosRg4D54q2saQ4pDKQTUZDa7F9sKYsj9
V5HmfHuX3arxdbr6AxtjGFVeSaBJlFuzRNxj6FCtMrVBqwmu4XxDNU1z9E6aBB9z
w+absshcpnRyqxVQZELIpq2tGj4WDBzRRZLeUmiaatXPbB0ZBkcRey4CSKnsPeEL
KH4BYBQ6PhhgQYx8BWnpTPbtdpL/PCZQPu4jfcTaV4Kbcfvaa11xSk/3G1F7Gg8g
b9bYGv2g+wP2EGPUBRq7wifrL/ME7PE9R7q2pSeYiUkZcDkwmLV6T8BbT9p7PDMd
VzTdqcd3ellYumt2UesDBC6Zjlgqd15UbpjGImE7jLpRqy8Y6XY/AvsTZxDhnzg8
EdG6DaAh5Wuc/QW+s59HQhNxn047myLEQgaQsnmj3Q==
=FUy1
-----END PGP SIGNATURE-----
