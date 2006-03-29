Subject: Re: MCS and unconfined_t
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: russell@coker.com.au
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <200603291136.58087.russell@coker.com.au>
References: <442933AD.3040208@kaigai.gr.jp>
	 <1143581268.3037.149.camel@moss-spartans.epoch.ncsc.mil>
	 <200603291136.58087.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 07:35:44 -0500
Message-Id: <1143635744.20394.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-03-29 at 11:36 +1100, Russell Coker wrote:
> The problem we have is that we want su(1) to allow changing to the SE Linux 
> context of the new user with the appropriate MCS categories.  To do this we 
> need to have su run in it's own domain so that it is permitted to increase 
> the categories while the unconfined_t domain isn't.  I plan to release this 
> as an FC5 update.
> 
> For the moment KaiGai Kohei is correct and there is no way to effectively 
> constrain unconfined_t.

Hmm...but su no longer uses pam_selinux, so it isn't supposed to change
SELinux context (aside from automatic transitions).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
