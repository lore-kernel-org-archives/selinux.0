Subject: Re: user guide draft: "Targeted Policy" review
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48C0CBF9.4090008@redhat.com>
References: <48BE3FB4.8020003@redhat.com>
	 <1220447961.6034.54.camel@moss-spartans.epoch.ncsc.mil>
	 <48C0CBF9.4090008@redhat.com>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 07:28:55 -0400
Message-Id: <1220614135.17197.280.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-09-05 at 16:04 +1000, Murray McAllister wrote:
> 
> I have moved this part to the "Unconfined Subjects" section. How about:
> 
> Unconfined subjects run in the unconfined_t domain. For subjects running 
> in this domain, SELinux policy rules are applied, but policy rules exist 
> that allow subjects running in this domain almost all access. Subjects 
> running in this domain almost always fall back to using DAC rules 
> exclusively. When an unconfined subject is comprised, SELinux does not 

s/comprised/compromised/

> prevent the attacker from gaining access to system resources and data, 
> and only DAC rules are used.

Otherwise, sounds fine.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
