Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SEXE1R013937
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 10:33:14 -0400
Received: from mail-yw0-f186.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3SEY0Mk000635
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 14:34:01 GMT
Received: by ywh16 with SMTP id 16so2908246ywh.32
        for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 07:32:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BD5AF15.8000301@redhat.com>
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com>
	 <1271972155.16202.55.camel@moss-pluto.epoch.ncsc.mil>
	 <4BD18CAE.4050201@redhat.com>
	 <20100426061848.GS21894@myhost.felk.cvut.cz>
	 <4BD58C7B.1000507@redhat.com>
	 <20100426143933.GU21894@myhost.felk.cvut.cz>
	 <4BD5AF15.8000301@redhat.com>
Date: Wed, 28 Apr 2010 10:32:56 -0400
Message-ID: <u2v10143821004280732jbeab15b9n4aba3dc70e34aaa4@mail.gmail.com>
Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
	suid
From: Karl MacMillan <karlwmacmillan@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 26, 2010 at 11:19 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 04/26/2010 10:39 AM, Michal Svoboda wrote:
>> Daniel J Walsh wrote:
>>> First my example was sort of a gross oversimplification.  It would not
>>> only effect unconfined_t but any other domain that could use the
>>> setuid bit to gain additional privs.
>>
>> If a domain can use uid=0 to get additional privileges then the MAC
>> policy has holes... like cheese and relies on DAC to plumb them. That
>> significantly reduces the utility of the MAC.
>>
> You have to look at this domain by domain, and the goal of users with
> MAC is to "target" certain domains.  If we went full lock down on every
> domain then we would not have > 70% of the fedora community running with
> SELinux enabeled in enforcing mode.
>
>>> unconfined_t to a user means, give him all the power of a normal user
>>> with SELinux disabled.  You are still protected by DAC.  I would argue
>>> that you want to make sure there are limited setuid apps around when
>>> running with unconfined_t.  But if you give him unconfined_t and
>>> "chcon 4755"  as a confined user running as root, then you make it
>>> easy for him to become unconfined_t running as UID=0.
>>
>> The problem with this reasoning is thus:
>>
>> 1) you give the user unconfined_t, well, okay, sad but perhaps necessary
>> 2) you give the user root
>> 3) you wonder that the user has root & unconfined
>>
>> I know that the root in (2) is 'bundled in' a MAC restricted domain but
>> since root is a DAC concept it propagates ('leaks') back to the DAC
>> world.
>>
>> You now want the MAC to stop the leak, but IMO that is a futile attempt.
>> It would take some serious analysis to find out how many ways 'root' can
>> leak out. I bet suid is not the only one. How about screwing up the web
>> server so that it runs as root and listens for your commands.
>>
> We are building higher fences around the prison.  I am not going for the
> perfect, since this is the enemy of the good.  We have lots of domains
> that require DAC privs.  It is the combination of DAC and MAC that make
> SELinux powerful.  Are goal is not to remove DAC checks in any way.
>>> If we want people to experiment with confined admins, allow unconfined_t
>>> - -> sudo_exec_t -> confined_admin_t is a good thing.
>>
>> People can experiment with confined admins as they like, but they should
>> note that as long as they have an unconfined element in the game the
>> system simply won't be secure. Default allow has never worked.
>>
> This is not default allow.  It is DAC + MAC as opposed to the way most
> people run, which is just DAC. I am trying to make setattr check better.
>
> DAC + sudo versus DAC + MAC + SUDO.

I thought that the intent of the current MAC / DAC interaction was
that capabilities are used to decompose root and MAC can restrict
capabilities on processes to add extra DAC protections. Now, I'll
admit a good deal of ignorance here, but is there a reason that we
can't just write policy using that mechanism to accomplish what you
are after? If we prevented confined admin domains with root from
having the needed capability to setuid files isn't that enough? Or if
the right capability doesn't exist, can't you add a new capability?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
