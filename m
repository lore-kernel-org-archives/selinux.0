From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "lky" <lky77@sjtu.edu.cn>, "SELINUX" <SELinux@tycho.nsa.gov>
Subject: Re: can't start X window in enforce mode
Date: Mon, 13 Oct 2003 08:11:28 +1000
References: <000901c390ef$d8b3c770$5d38a8c0@lky>
In-Reply-To: <000901c390ef$d8b3c770$5d38a8c0@lky>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200310130811.28355.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 13 Oct 2003 04:37, lky wrote:
>-------------- Why the system didn't display the denied message if the
> opration violate the policy? How should I configure my policy in order to
> start the X window? Thanks!

# memory_device_t access is needed if not using the frame buffer
dontaudit $1_xserver_t memory_device_t:chr_file read;

The above is the relevant section of policy in
macros/program/xserver_macros.te.  The X server tries to access /dev/mem even 
if it doesn't need to.  Change the dontaudit rule to an allow for 
rw_file_perms and it should work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
