From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "lky" <lky77@sjtu.edu.cn>
Subject: Re: policy configuration problems
Date: Fri, 10 Oct 2003 16:48:24 +1000
Cc: "SELINUX" <SELinux@tycho.nsa.gov>
References: <002201c38ecf$814345f0$5d38a8c0@lky>
In-Reply-To: <002201c38ecf$814345f0$5d38a8c0@lky>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200310101648.24204.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Oct 2003 11:40, lky wrote:
> Absolutely right! The file contexts aren't labelled correctly. After make
> relabel and append some allow rules the most programes run within their own
> domains and denied messages have been eliminated. Thanks!

What allow rules did you have to add?  Some of them may be worth adding to the 
default policy (which will save you some effort in the future).

>  I want to use webmin to configure the system remotely,but now the webmin
> daemon still run within the initrc_t domain. I didn't find the .te and .fc
> files under the policy/domain/program and /policy/file_context/
> directories.

Correct, no-one has written policy for webmin.

> Should I have to create a new domain and a new .fc file for
> the program?

Yes.

> I think it's fairly hard for me because webmin is a
> complicated program and I'm not very family with it. Is there any easier
> way I can take or can I add the webmin program to an existing domain?

Probably not.  I suggest giving it a go.  If you get stuck then ask for some 
advice here.

> -------------------------------------------------------------------------
> Another question:
> I'm not sure about my policy configuration steps.After changing the policy
> I take the following steps: 1.make reload
> 2.create the initrd-xx.img file
> 3.reboot
> 4.make relabel
> 5.reboot

1 is necessary to get the policy installed and have it take affect.

2 is necessary to make it take affect on the next boot (but we are working on 
solutions to this problem).

3 should never be necessary unless you want to test things.

4 is only needed if you add a new .te file (which adds the .fc file to 
file_contexts) or if you edit any of the .fc files.  But in that case you can 
probable use the -s option to setfiles to get the labelling you need done in 
far less time.  Also the "reboot ; make relabel ; reboot" process is only 
needed for an initial install.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
