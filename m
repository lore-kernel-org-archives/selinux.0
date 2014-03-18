Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2I6gHPr021565
 for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2014 02:42:17 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: SELinux design and Domain Name resolution
From: Joe Nall <joe@nall.com>
In-Reply-To: <DA8D339A60101247B36E202899B1C93AB4E6EC@CHUNEX01.integrity-apps.com>
Date: Tue, 18 Mar 2014 06:42:13 +0000
Message-Id: <0D6F270F-F5A8-42B8-ACEB-74310AD056CD@nall.com>
References: <DA8D339A60101247B36E202899B1C93AB4E642@CHUNEX01.integrity-apps.com>
 <119BEE8C-D8D7-4761-8D05-89C11215FD81@nall.com>
 <DA8D339A60101247B36E202899B1C93AB4E6EC@CHUNEX01.integrity-apps.com>
To: "Langland, Blake" <blangland@integrity-apps.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On Mar 17, 2014, at 11:09 PM, Langland, Blake <blangland@integrity-apps.com> wrote:

> So you are running multiple servers at single levels? Or a single server at multiple levels with multiple interfaces?

In Apache 1.3.X, one of the 'ServerType' options was 'inetd'. This uses xinetd to listen on a socket and launch a brand new Apache instance on each connection. The Apache instance then does its IO on STDIN/OUT at the security context of the connection. The issues with this are that Apache 1.3.X is no longer supported and this is more heavyweight than a threaded IO or eventing IO HTTP server. On multicore servers, it is much faster than you would expect.

If you are into more hip technology, you can launch node.js the same way with a small tweak to the node libraries or roll your own server

> 
> How does the http redirector determine what level the communication is at so that it can redirect it to the correct interface?

secon -s or the python selinux library binding.

Try something like:
http://sites.psu.edu/psuvoip/2013/03/05/xinetd-as-a-poor-mans-web-server-for-issuing-redirects/
and then replace the script with one that issues a level based redirect once you have that working.

The general idea is not to write a new MLS socket server if you can help it. xinetd is the swiss army knife of network servers and the SELinux extension is well done. You will need to use netlabel or labeled IPSec to set the context of the incoming connection.

joe

> 
> -----Original Message-----
> From: Joe Nall [mailto:joe@nall.com] 
> Sent: Monday, March 17, 2014 10:50 AM
> To: Langland, Blake
> Cc: selinux@tycho.nsa.gov
> Subject: Re: SELinux design and Domain Name resolution
> 
> You could write a level based http redirector. This is much simpler than a dns fix. It could be as simple as a xinetd launched python/bash/perl script, where xinetd does the mls network listening and the script issues a 302 redirect to the real server.
> 
> We use a lightly hacked Apache 1.3.42 launched out of xinetd and it is more than capable of keeping up with the transaction rate (~100/second) we need.
> 
> joe
> 
> On Mar 17, 2014, at 5:01 PM, Langland, Blake <blangland@integrity-apps.com> wrote:
> 
>> Hello,
>> 
>> I have a couple general design questions in relation to SELinux but I need to explain my whole situation for them to make sense, so here it goes...
>> 
>> I am working on implementing a MLS SOA architecture and we are trying to use SELinux. I would like to explain our current plan and hopefully get some feedback from people who have done similar work. Basically, our team is tasked with taking an existing SOA and turning it into a MLS SOA. The existing SOA Architecture is fairly typical with things like a machine running Apache web server which proxies requests to a machine running Tomcat; Let's focus on these machines and two security domains.
>> 
>> In order to create two domains, we would need a web server and Tomcat at each level, so we have two installations of Apache on VM A and two installations of Tomcat on VM B. Since clients expect Apache to bind on standard ports (80 & 443) it made sense to have each installation bind on a different network interface, so each VM has two network interfaces, one for each domain. Is this a typical way to achieve the separation we want? Should we have each Apache and Tomcat instance bind on the same interface but use different ports? Does it even make sense to have two web servers, or two Tomcat instances running on the same machine (as opposed to using two VMs for each level)?
>> 
>> The problem that we have run into with our current approach (1 VM, 2 installations, and 2 Network interfaces) is domain name resolution. We are essentially given these applications (Apache, Tomcat, among many other) as black boxes that we plug into our environment. For example, if the Apache we are given knows the Tomcat VM as "tomcat", we would need to modify each Apache instance to then proxy to the appropriate Tomcat VM interface, such as "tomcat_a" and "tomcat_b." This is further complicated on the Tomcat VM as it is running OWF with also expects other web applications to exist at "tomcat." Since we are given these as "black boxes," we can't really go find all configurations that reference "tomcat" and change it to either "tomcat_a" or "tomcat_b."
>> 
>> Any comments or previous experiences would be greatly appreciated.
>> 
>> Thanks,
>> Blake Langland
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
