Message-ID: <5385DD15.8070707@tycho.nsa.gov>
Date: Wed, 28 May 2014 08:56:53 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: kim.lawson-jenkins@nrl.navy.mil, selinux@tycho.nsa.gov
Subject: Re: attempting to run a sftpserver in a confined domain
References: <006b01cf79f7$52566370$f7032a50$@nrl.navy.mil>
In-Reply-To: <006b01cf79f7$52566370$f7032a50$@nrl.navy.mil>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/27/2014 06:02 PM, Kim Lawson-Jenkins wrote:
> Hi,
> 
>  
> 
> We are writing SELinux policy for a sftp server to run in a confined
> domain when an openssh sftp connection is made to it.    
> 
>  
> 
> Using ls -Z we can see the running process labeled as
> 
>  
> 
> system_u:system_r:sshd_t: s0-s15:c0.c1023      root                 
> sshd: guard [priv]
> 
> system_u:system_r:sshd_t :s0-s15:c0.c1023      guard               sshd:
> guard@notty
> 
> system_u:system_r:unconfined_t:s0-s15:c0.c1023      guard   
> /usr/lib/openssh/sftpserver 
> 
>  
> 
> with the sftpserver running in the unconfined domain rather than the
> confined domain sftpserver.  The sftp-server executable file is labeled as
> 
>  
> 
> system_u:system_r:sftpserver_exec_t:s0-s15:c0.c1023
> 
>  
> 
> in the directory /usr/lib/openssh.
> 
>  
> 
> The policy module contains the following statements –
> 
>  
> 
> attribute sftpserver;
> 
> ssh_server_template(sftpserver)
> 
> iptables_domtrans(sftpserver_t)
> 
> type sftpserver_exec_t;
> 
> init_daemon_domain(sftpserver_t, sftpserver_exec_t)
> 
> allow sshd_t sftpserver_exec_t:file { getattr execute ioctl };
> 
>  
> 
> corenet_tcp_connect_ssh_port(sftpserver_t)
> 
> corenet_tcp_bind_ssh_port(sftpserver_t)
> 
> corenet_tcp_sendrecv_ssh_port(sftpserver_t)
> 
>  
> 
>  
> 
> Is there a boolean that will block the sftpserver from running in the
> unconfined domain, and are there missing policy statements that will
> allow the sftpserver to run in the confined domain?

This is a refpolicy-specific question and thus should go to the
refpolicy mailing list.

I'd would guess that sshd is explicitly setting the context when
launching the sftpserver based on your seusers and users configurations
(semanage login -l; semanage user -l) for the guard user?
