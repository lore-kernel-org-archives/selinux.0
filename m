Subject: Re: mcs policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30801241606r759b2de8hf3345ac0f375eb05@mail.gmail.com>
References: <dd18b0c30801241606r759b2de8hf3345ac0f375eb05@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 25 Jan 2008 13:36:54 -0500
Message-Id: <1201286214.21288.271.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-24 at 16:06 -0800, Justin Mattock wrote:
> Hello I was wondering if this is possible with the mcs policy: when
> using firefox I would issue newrole -r user_r -l s0-s0:c10.c20 then
> start firefox with these numbers, then if I wanted to start
> streamtuner issue newrole -r user_r -l s0-s0: c190.c200 to listen to
> music. Now I've noticed when I'm in the firefox role and categories
> streamtuner still starts, is there a way to keep this from happening? 

I'd suggest just using the TE policy, and defining different domains for
firefox and streamtuner.  I don't think MCS is really what you want
there - it is a user-oriented access control scheme.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
