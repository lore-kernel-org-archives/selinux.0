Subject: Re: About Negation Special Operator
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820609260834k1c885675se75ad4ad82fe0dac@mail.gmail.com>
References: <f71a82820609260834k1c885675se75ad4ad82fe0dac@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 07:44:43 -0400
Message-Id: <1159357483.32075.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-27 at 00:34 +0900, Shintaro Fujiwara wrote:
> Hello.
> 
> I have a question on writing a modular policy.
> When I want to allow someting like,
> 
> allow domain { exec_type -sbin_t } : file execute;
> 
> module test_policy 1.0.0;
> 
> require {
> 	attribute domain;
> 	type sbin_t;
> 	class file execute;
> }
> allow domain { exec_type -sbin_t } : file execute;
> 
> will suffice or should I add every exec_type
> in require brace?

You need to require the exec_type attribute, but not the list of types
it contains (naturally).  The attribute will be expanded after all
modules have been linked together, at which point we know the full set
of types.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
