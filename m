Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: pppd with ipppd
Date: Sun, 8 Sep 2002 19:26:06 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <20020906174227.C97B8FA8D@ivanova.coker.com.au>
In-Reply-To: <20020906174227.C97B8FA8D@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <200209081926.06666.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Firstly in future please supply patches made with "diff -u", this saves time 
for people who merge them (otherwise they have to run diff themselves), and 
it means that the patches may still apply if you generated them from an old 
version of the source.

On Fri, 6 Sep 2002 19:41, Carsten Grohmann wrote:
> I follow your suggestion and add the few line for the ipppd to the pppd_t
> domain. The attached files contains the rules and the patch for the
> net_context and network.te files.

I've applied the change to the file contexts in my tree.

Why does ipppd need to run "ifconfig" while the regular pppd doesn't?  Or is 
it some script that calls ifconfig?

Also I expect that ifconfig does not need udp access to pppd_t, it would be 
just another instance of pppd not setting it's file handles to close on exec.

> May be that some rule is SuSE specific. I missing labeling the password
> files in your rules. Don't you use it?

What do you mean?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
