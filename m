Subject: Re: file contexts and modularity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Janak Desai <janak@us.ibm.com>, Karl MacMillan <kmacmillan@tresys.com>,
   selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1120077839.20484.104.camel@celtics.boston.redhat.com>
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
	 <1120073041.20484.70.camel@celtics.boston.redhat.com>
	 <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
	 <1120075381.20484.75.camel@celtics.boston.redhat.com>
	 <42C302F9.4080901@us.ibm.com>
	 <1120077839.20484.104.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:56:13 -0400
Message-Id: <1120139773.11798.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-29 at 16:43 -0400, Ivan Gyurdiev wrote:
> So...how will pre-creation work if the file_contexts.homedirs
> file is erased (the only many:1 map available, 
> which becomes 1:1 given evaluation order).

I think you'd have a separate config file, which contains templates not
pre-expanded entries per user, and have the polyinstantiated directory
support handle initial setup and labeling when a per-role directory is
first created.  

Of course, we are getting rather ahead of ourselves here, as we don't
even have the basic polyinstantiated directory support in FC/devel
yet...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
