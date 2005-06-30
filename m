Date: Thu, 30 Jun 2005 01:40:27 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: gyurdiev@redhat.com, Janak Desai <jdesai@us.ibm.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: Re: file contexts and modularity
Message-ID: <20050630004027.GD8415@lkcl.net>
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com> <1120073041.20484.70.camel@celtics.boston.redhat.com> <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 29, 2005 at 03:50:57PM -0400, Stephen Smalley wrote:

> So at that point you no longer need to keep home directory contexts in
> file_contexts at all, and you just exclude home directories from
> relabeling.

 yessss :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
