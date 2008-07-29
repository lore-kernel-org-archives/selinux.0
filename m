Subject: Re: unconfined_t and user_home_dir_type
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200807291850.30191.russell@coker.com.au>
References: <200807291850.30191.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 29 Jul 2008 07:33:39 -0400
Message-Id: <1217331219.20373.139.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-07-29 at 18:50 +1000, Russell Coker wrote:
> Currently we have the attributes user_home_dir_type and user_home_type applied 
> to the main types for the home directory of regular users in a strict policy 
> configuration (this means user_t etc).
> 
> While it is possible to have unconfined_t and user_t on the same system, I 
> don't expect this to be a common configuration.  In fact I expect that in 
> practice they will be mutually exclusive.

Actually, it is a common situation in modern Fedora - they can map users
they wish to confine to user_u (and thus to user_t) while leaving e.g.
root as unconfined_u and thus unconfined_t.

> 
> Therefore when unconfined_t is used it will be desired that they can do all 
> normal things, such as having a POP server read mail from their ~/Maildir.  
> Allowing such access would mean adding user_home_dir_type and user_home_type 
> attributes to unconfined_home_dir_t and unconfined_home_t respectively.
> 
> Is there any reason for not doing this?
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
