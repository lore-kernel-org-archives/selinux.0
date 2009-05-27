Subject: Re: Unexpected role change from custom role back to user_r
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "West, Gary-P55389" <Gary.West@gdc4s.com>
Cc: selinux@tycho.nsa.gov, clip@oss1.tresys.com
In-Reply-To: <FA8938DBA959E546BF6527F085F22FF804C16BB4@AZ25EXM04.gddsi.com>
References: <FA8938DBA959E546BF6527F085F22FF804C16BB4@AZ25EXM04.gddsi.com>
Content-Type: text/plain
Date: Wed, 27 May 2009 13:40:33 -0400
Message-Id: <1243446033.2752.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-27 at 10:23 -0700, West, Gary-P55389 wrote:
> I have a custom SELinux policy (based on clip), user and role that
> will login through X windows. When the user logs in, see the
> USER_ROLE_CHANGE to the desired role. All X clients have the user_r
> and user_t and not the custom role and type shown in the
> USER_ROLE_CHANGE message. Can someone explain how this secondary role
> change would happen?

Not offhand.  Can you supply more details, please?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
