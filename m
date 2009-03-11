Subject: Re: Significance of the level on a port configuration
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andy Warner <warner@rubix.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <49B7F893.9040706@rubix.com>
References: <49B7F893.9040706@rubix.com>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 13:47:19 -0400
Message-Id: <1236793639.14649.67.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-03-11 at 18:44 +0100, Andy Warner wrote:
> Can someone give me a quick overview of the significance (i.e., the
> MLS behavior) of the port level for SELinux. 
> 
> I am attempting to have two connection from untrusted hosts that are
> statically labeled (with netlabelctl) one at high (s0) and one at low
> (s1). Both connections will be made over the same port number. The
> service accepting the connections runs at SystemHigh on Fedora 9 with
> MLS policy. What difference does the level of the port make ? Assume
> all TE rules are satisfied for the context of my question.
> 
I don't think the port level should make any difference.  Are there any
MLS constraints defined on any of the permission checks that are based
on port contexts?
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
