Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o29GRJlA017823
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 11:27:19 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o29GQwqP026451
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 16:26:59 GMT
Message-ID: <4B9676E1.1000905@redhat.com>
Date: Tue, 09 Mar 2010 11:27:13 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: michel m <michel.mcgregor@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: domain transition issue
References: <bb74313d1003090553k3e3d092ep619f337a8591670@mail.gmail.com>
In-Reply-To: <bb74313d1003090553k3e3d092ep619f337a8591670@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/09/2010 08:53 AM, michel m wrote:
> Hello,
> I need to run an unconfined process in a confined domain, say httpd_t. 
> To do so, I changed executable file's context to a confined one, say 
> httpd_exec_t, but after running it, its process was in unconfined 
> domain again.
> As I searched more, I found that there is not a legal transition for 
> an unconfined process to a confined one in normal form. I created an 
> script file which contained scripts for running my desired 
> application, changed script's context to initrc_exec_t. after running 
> this script, I get my process unconfined again.
> may some one guide me how to resolve this issue and run my application 
> is unconfined domain?
>
> Regards.
If you want to transition from unconfined_t to httpd_t you need to 
execute a script labeled initrc_exec_t.

unconfined_t -> initrc_exec_t -> initrc_t -> httpd_exec_t -> httpd_t

So you need the init script labeled initrc_exec_t and the program you 
want to run as httpd_t to be labeled httpd_exec_t.

I would add an id -Z to your initrc_exec_t script to make sure the 
transition happened.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
