Subject: Re: Roles (FC3)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?iso-8859-2?Q?Jaros=B3aw?= Nozderko <jaroslaw.nozderko@polkomtel.com.pl>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <6A23B769A5F0B845A479F7F33CCC9B380CFACFC4@E2K1.corp.plusnet>
References: <6A23B769A5F0B845A479F7F33CCC9B380CFACFC4@E2K1.corp.plusnet>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1104762406.16598.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 Jan 2005 09:26:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-03 at 05:20, Jarosław Nozderko wrote:
> Everything is OK if paul has default role and type. However, I'd like to
> create custom role, according to [1]:
> 
> domains/user.te:
> 
> full_user_role(paul)

To enter the role via su (or similar programs, vs. login-style
programs), you'll also need:
	role_tty_type_change(user, paul)

Or likewise for whatever roles you want to transition from.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
