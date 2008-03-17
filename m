Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2HIvi6q002049
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2008 14:57:44 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2HIvhCw022558
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2008 18:57:43 GMT
Message-ID: <47DEBA68.8070105@redhat.com>
Date: Mon, 17 Mar 2008 14:37:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
CC: selinux@tycho.nsa.gov
Subject: Re: prelink, cron-job and SELinux compliance
References: <1204970465.4229.10.camel@vogon>  <47D530DC.5030606@redhat.com> <1205667915.2932.9.camel@vogon>
In-Reply-To: <1205667915.2932.9.camel@vogon>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefan Schulze Frielinghaus wrote:
> On Mon, 2008-03-10 at 09:00 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Stefan Schulze Frielinghaus wrote:
>>> In RHEL/CentOS 5.1 a cron job (/etc/cron.daily/prelink) runs prelink.
>>> The cron job itself removes a file (/etc/prelink.cache) if necessary and
>>> updates the database. This does not work with the strict SELinux policy.
>>>
>>> To solve this I patched the prelink application to
>>> use /var/cache/prelink/prelink.cache instead of /etc/prelink.cache
>>> This would make it more easier to write SELinux policies. But know my
>>> actual question is how to modify the cron job to work properly? All cron
>>> jobs on my system are labeled as bin_t. This would mean that
>>> system_crond_t needs write/create etc. permissions
>>> on /var/cache/prelink. Thats not really nice and I would prefer to
>>> create a domain like cron_script_prelink_t for /etc/cron.daily/prelink
>>> which gets all the rights to manage /var/cache/prelink.
>>>
>>> What are your ideas to handle cron scripts properly?
>>>
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>> the words "unsubscribe selinux" without quotes as the message.
>> Does labeling the directory cron_var_run_t make it work?
>>
>> Please open a bug report on prelink to put the cache file in this new
>> directory.
> 
> The relabel did not solve the problem (AVCs are attached).
> 
> #============= prelink_t ==============
> allow prelink_t crond_var_run_t:dir { remove_name add_name };
> allow prelink_t crond_var_run_t:file { write rename create setattr };
> 
> #============= system_crond_t ==============
> allow system_crond_t crond_var_run_t:dir { write remove_name add_name };
> allow system_crond_t self:process setfscreate;
> 
> Should we create a special type for this purpose (like already
> mentioned: cron_script_prelink_t and label the
> file /etc/cron.daily/prelink)?
> 
> I opened a bug: https://bugzilla.redhat.com/show_bug.cgi?id=437684
> 
> cheers
> Stefan
> 
> PS: Sorry for responding so late but I did not have a Internet
> connection during last week.
> 
I think  you would need to label the individual scrips and setup proper
transitions to make this work correctly.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfeumgACgkQrlYvE4MpobPtowCfU3DiAWPpFwb3ZbpLUOjpZxH3
ZhcAoKFxYqs2rzi+Mzor87SY8QeRhQmp
=D2qQ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
