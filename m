Message-ID: <3B7D98DA.B4EA0C3C@earthlink.net>
Date: Fri, 17 Aug 2001 15:21:14 -0700
From: John Scroggins <dataefx@earthlink.net>
MIME-Version: 1.0
To: Conan Callen <ccallen@windowpane.com>
CC: SELinux@tycho.nsa.gov, "\"\\\"Christopher Mahmood\\\"\"" <ckm@suse.com>
Subject: Re: Partial TOC for Comment]
References: <3B7C7C69.E7B84C68@earthlink.net> <003f01c12746$e02faf60$3a8314d1@nwlink.com> <3B7D75C0.23A2B9C9@earthlink.net> <005501c12758$95f6cf70$3a8314d1@nwlink.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Conan Callen wrote:
> 
> .. this is your chance to volunteer....  :)
> 
> In the early 90's, I maintained a kornshell based installer for a unix
> product (cim21 by Industrial Systems, bought up by AspenTech). That was a
> while ago, but after I get my server up and running (and get SELinux
> installed :) It had two parts, one would pull all the required files out of
> the build tree and tar them up, and second part was the actual installer. I
> rember much of how it was written, I think the key was the configuration
> files. Once I get the fires under control I can play around with it.

Sounds like a plan ... when you are ready to start on something like
that we will need to talk to Chris M. also 
> 
> On a different topic (installing linux and immediatly getting cracked):
> An interesting note. As soon as I finished installing Linux lastnight, I
> noticed the hard drive start whirling like someone was there doing searches
> of my hard drive. This morning I got the same thing. I ran ps -aux and could
> see a process as root running a something like ls | awk ... looking for
> different things. I didnt take time to write it down, I just shut the
> machine down.

Next time let it run till you find the suspect process and identify its
function (you can minimize the affect by disconnecting the ethernet
cable instead of shutting down the machine..) 
> 
> It appears that as soon as I was done installing the system it was
> compromised. It made me think that there must be hundreds / thousands of
> people installing linux everyday and have the same thing happen and dont
> even realize it. Its like the machine puts out a message to the internet as
> soon as you turn it on "please, come hack me!"

Its unfortunate, but the 'net is being scanned constantly, most of the
time with automated tools. That is why it is essential to follow
specific protocols when setting up secure installations. I have had it
happen to me -- a few years ago ;) 
> 
> Im in the process of locking the machine down now. I stared by pulling the
> ethernet cable. Does SELinux help to make it tougher for the crackers to
> gain access like this? Know of any good webpages / books on how to get
> started (steps) on locking down a system, and creating scripts to monitor
> the system?

Without knowledge of "how" your box was _rooted_ , I will make a broad
brush statement: 

The flask architecture should significantly hinder processes that may be
exploited. Processes like httpd, ftpd, vixie-cron, and other other
vulnerable processes can be segregated into different domain/roles, and
if attacked and exploited, they will have to check with the kernel
subsystem (security server), which limits their system interaction based
on the policy configuration. 

You might want to check out http://www.rootprompt.org ,
http://www.sans.org and http://www.cert.org  (also try
www.ciac.llnl.gov)

Tip:

1) never install your system on the wire (hooked up), unless it is an
ftp/nfs install. 
2) after you install, run tripwire or some other file integrity checking
program. Or you can issue this command 
#/  touch chk.log 
#/ rpm -Va >  chk.log 
to let you know which packages were installed.

3) run 
#/ netstat -na |less 

and verify open ports 21-ftp 22-ssh 23-telnet 25-smtp 111 - 113-  

4) edit your /etc/inetd.conf (I think redhat uses a file called
/etc/services) file to limit services running and open ports.

5) install and configure  "portsentry"

6) install logcheck (or logwatch, whichever you prefer-)

7) setup a firewall (on a separate box) and run ipchains with Seattle
Firewall or pmFirewall or whatever you like 

8) plug it in and watch your logs ...  

Cheers.. 

--JS      
 
> Conan
>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
