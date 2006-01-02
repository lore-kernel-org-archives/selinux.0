Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k025uiXf004731
	for <selinux@tycho.nsa.gov>; Mon, 2 Jan 2006 00:56:45 -0500 (EST)
Received: from www346.sakura.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k025tfYl016076
	for <selinux@tycho.nsa.gov>; Mon, 2 Jan 2006 05:55:43 GMT
Message-ID: <43B8C098.30101@kaigai.gr.jp>
Date: Mon, 02 Jan 2006 14:56:40 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: linux-security-module@wirex.com, "SELinux(NSA)" <selinux@tycho.nsa.gov>
Subject: Re: SELinux metadata protection
References: <43B6C9E3.8020406@kaigai.gr.jp> <20060101192707.GA19487@sergelap.austin.ibm.com>
In-Reply-To: <20060101192707.GA19487@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> Hmm, a question on behavior.
> 
> Let's say hallyn_t is allowed to write /var (var_t), but not to do
> getattr on /var/secret_process_is_running (secret_t).  If hallyn_t
> does ls /var/secret_process_is_running, he gets -ENOENT, but what
> should he get if he does 'touch /var/secret_process_is_running'?
> -EPERM obviously leaks information...

In my implementation, -ENOENT can be returned if he tries to create
new file with same name as existing unauthorized files.
Becase resolving filename is done before DAC permission checking,
and security_inode_lookup() is called inside path_walk().
(security_inode_permission() is called _after_ DAC permission checking.)

But I'm still thinking what is appropriate error code...

# I don't know whether it's true or not. I've heard that commercial Trusted OS
# creates a new file in separated namespace on such a situation.
# But it's obviously out of the scope of SELinux, I think.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
