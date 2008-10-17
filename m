Message-ID: <48F90109.1030005@redhat.com>
Date: Fri, 17 Oct 2008 17:18:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org,
        sgrubb@redhat.com
Subject: Re: [PATCH] selinux: new permission for chmod on suid or sgid files
References: <1224258034.3189.25.camel@paris-laptop>	 <1224262355.19562.78.camel@moss-spartans.epoch.ncsc.mil>	 <1224264294.19562.92.camel@moss-spartans.epoch.ncsc.mil>	 <48F8DCE3.3000805@redhat.com>	 <1224269637.19562.115.camel@moss-spartans.epoch.ncsc.mil>	 <48F8E333.3060905@redhat.com>	 <1224272365.19562.144.camel@moss-spartans.epoch.ncsc.mil>	 <1224273875.3189.46.camel@paris-laptop> <1224274196.19562.165.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1224274196.19562.165.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2008-10-17 at 16:04 -0400, Eric Paris wrote:
>> On Fri, 2008-10-17 at 15:39 -0400, Stephen Smalley wrote:
>>
>>> I don't follow the above.  First, the CAP_SETUID capability controls the
>>> ability to use set*uid() system calls, not to execute setuid binaries
>>> (aside from a special case for shared state).  Second, if some other
>>> confined domain executes a setuid binary created by this user, it is
>>> still limited by the permissions granted to that original confined
>>> domain as far as SELinux is concerned.
>> He's saying there are almost 200 domains that can run setuid apps.
> 
> As I said, CAP_SETUID isn't about whether or not you can run a setuid
> app.  You can do that without CAP_SETUID.  Obviously since a normal
> unprivileged user shell can run a setuid program in the first place.
> 
>> Limiting the number of domains that can create new setuid apps limits
>> the number of places that these domains can go.  Clearly they are all
>> still confined to their domain and whatever it allows, but allowing them
>> to gain root priveledges may give them the ability to attack other parts
> 
> Wait - how did they gain root privileges?  root privileges are
> capabilities, and we control capabilities based on domain.
> 
>> of the system normally controlled by dac.  This certainly doesn't lessen
>> the MAC confinement.  Lets assume an audited system in which we are
>> certain the only suid app untrusted users are allowed to run is ping.
>> So the users have the right to run suid apps.  They are protected from
>> each other by DAC.
>>
>> Confined webadmin writes a program which is clears out other users
>> public_html when they get a spurious DMCA takedown notice.  He then
>> (because he is a lazy bumbling idiot) makes his script suid so he does
>> not have to go into his confined webadmin account constantly to delete
>> users webpages.
> 
> He could also make a daemon that runs under his uid and accepts commands
> via local socket.
> 
>> Normal DAC protects user2 from being attacked by user1.  Because of the
>> bumbling incompetance of confined webadmin user1 can now use this setuid
>> app to do things which he is allow by selinux policy but denied by
>> normal DAC permissions.
>>
>> Why did webadmin need to make a setuid app to begin with?  file caps are
>> already protected by CAP_SETFCAP.  Lets assume system policy says that
>> su should not be setuid.  Should the webadmin really be allowed to
>> easily override that system policy because he wants to use su - to get
>> to his confined domain instead of sudo?
> 
> He can't get to his confined domain via some other program unless policy
> says he can.  He can only get to some other uid that way.
> 
>>   She bumbling idiot really be
>> allowed to say add o+x to su - when the system policy only really wanted
>> group wheel to be able to run su?  Should the bumbling idiot be able to
>> remove the suid flag from a program and not be able to fix it?
>>
>> I think there are some real gains that can be made by limiting how
>> confined admins or untrusted users can deal with suid apps.
>>
>> I'd probably be inclined to add changing the uid/gid/other things that
>> clear setuid to be things which require this permission.  I don't see a
>> reason to allow my webadmin to chown su to himself...
> 
> He can't do that unless he owns su (or that itself is subject to
> fowner).  And chown'ing or writing to a suid app clears the suid bit
> forcibly. 
> 
> Come on, guys, you can do better.
> 
This hole discussion has actually opened me up to a new understanding.
SELinux right now does not prevent the execution of setuid applications
if you do not have setuid capability, it only prevents you from running
apps that actually execute the setuid() call.

I think this is a problem.  One of the things I have been saying in my
presentations is that running as staff_t will prevent you from running
any setuid application unless a transition is defined.  Turns out this
is wrong and I was lying.

# cp /usr/bin/id /usr/bin/myid
# chmod 4755 /usr/bin/myid

$ myid
uid=3267(dwalsh) gid=3267(dwalsh) euid=0(root) groups=3267(dwalsh)
context=staff_u:staff_r:staff_t:s0

So running a chmod o+s file as staff_t will run as EUID 0.  I think this
is something SELinux should block.  At least treat this the same way a
file system mounted nosetuid would.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkj5AQkACgkQrlYvE4MpobPUJQCg5qRoFCBYh/bj1XU509v63F0H
UawAmwX5xiCLM85U8ZxupBzj5XEd68Jp
=paj/
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
