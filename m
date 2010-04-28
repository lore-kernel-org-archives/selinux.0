Message-ID: <4BD8816A.6050704@redhat.com>
Date: Wed, 28 Apr 2010 14:41:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <karlwmacmillan@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
 	suid
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com>	 <4BD18CAE.4050201@redhat.com>	 <20100426061848.GS21894@myhost.felk.cvut.cz>	 <4BD58C7B.1000507@redhat.com>	 <20100426143933.GU21894@myhost.felk.cvut.cz>	 <4BD5AF15.8000301@redhat.com>	 <u2v10143821004280732jbeab15b9n4aba3dc70e34aaa4@mail.gmail.com>	 <4BD856B5.9000405@redhat.com>	 <h2m10143821004281057t2f22085cvc7ea1a9937a4531@mail.gmail.com>	 <1272478063.6013.216.camel@moss-pluto.epoch.ncsc.mil> <g2p10143821004281131t20db89cbt1d63f08121b86169@mail.gmail.com>
In-Reply-To: <g2p10143821004281131t20db89cbt1d63f08121b86169@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/28/2010 02:31 PM, Karl MacMillan wrote:
> On Wed, Apr 28, 2010 at 2:07 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On Wed, 2010-04-28 at 13:57 -0400, Karl MacMillan wrote:
>>> On Wed, Apr 28, 2010 at 11:39 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>>>>> This is not default allow.  It is DAC + MAC as opposed to the way most
>>>>>> people run, which is just DAC. I am trying to make setattr check better.
>>>>>>
>>>>>> DAC + sudo versus DAC + MAC + SUDO.
>>>>>
>>>>> I thought that the intent of the current MAC / DAC interaction was
>>>>> that capabilities are used to decompose root and MAC can restrict
>>>>> capabilities on processes to add extra DAC protections. Now, I'll
>>>>> admit a good deal of ignorance here, but is there a reason that we
>>>>> can't just write policy using that mechanism to accomplish what you
>>>>> are after? If we prevented confined admin domains with root from
>>>>> having the needed capability to setuid files isn't that enough? Or if
>>>>> the right capability doesn't exist, can't you add a new capability?
>>>>>
>>>>> Karl
>>>> Write now the ability to setattr on a file gives you the ability to
>>>> chmod 4755 EXE on types you control.
>>>>
>>>> But we want to allow chmod 755 EXE but prevent chmod 4755.  Eric is
>>>> adding a Access check for this.
>>>
>>> I understand that, but I (and I think others) are concerned about
>>> directly adding permissions for what is essentially DAC policy. I was
>>> wondering why the current strategy of mitigating DAC with SELinux
>>> through capabilities is not workable in this case. That has the
>>> additional benefit of allowing non-SELinux systems to benefit as well
>>> if new capabilities are needed.
>>
>> Setting the suid bit on a file is not a privileged operation on
>> Unix/Linux, so there is no capability check on it and you can't add a
>> capability check to it without breaking Unix/Linux compatibility.  Any
>> user is free to create his own "entrypoints" to his own uid/gid in this
>> manner at present.  Dan wants to be able to prevent that, particularly
>> since he is trying to give a non-root user the ability to run confined
>> root shells.
>>
> 
> Ok - thanks for the explanation. You make it sound almost as if DAC is
> discretionary.
> 
> Next stupid question then - is disallowing setattr for these shells
> either not sufficient to achieve the desired security or not workable
> in practice? I know the goal is to allow chmod but just not allow
> creation of root owned setuid files, but is allowing chmod really
> necessary for these limited use shells? Again, I'm just trying to
> avoid the slippery slope of adding fine-grained control over DAC to
> SELinux.
> 
> Karl

My use case was of the web administrator creating cgi scripts.  Being
able to copy files into a directory and then chown and chmod would be
the use case.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvYgWoACgkQrlYvE4MpobOzTACfWUOhYXlms/NIaeLQJfEpkQIq
m6cAoJNCJCb55Xkt/nW85A5CeXdhKB5R
=j1PM
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
