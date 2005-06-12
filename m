Message-ID: <42AC457C.6020805@tresys.com>
Date: Sun, 12 Jun 2005 10:23:56 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: "SELinux(NSA)" <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] independent with attribute declararion oeder for attachment
References: <42AC23B6.8070304@kaigai.gr.jp>
In-Reply-To: <42AC23B6.8070304@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:

><snip>
>
>The following actions are same as current checkpolicy.
>* ALLOW and any TE statements with undeclared attributes are restricted.
>* Duplicate attribute declaration is restricted.
>
>* Any attribute need a declaration by ATTRIBUTE statement.
>
It is undesirable to implicitly declare symbols by using them. In fact
with the loadable policy modules this becomes problematic since we have
to keep track of all dependancy information. For example, since roles
are declared implicitly when assigned a type it isn't possible to
discern declaring a role from using a role. In a module using a role
should always have a dependancy on the role but declaring it wouldn't.
This is something we are trying to solve but adding more implictly
declared symbols would only make it harder.

Joshua Brindle


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
