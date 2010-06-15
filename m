Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5FED3qo020811
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2010 10:13:03 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5FECCtq005972
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2010 14:12:13 GMT
Message-ID: <4C178A66.60207@redhat.com>
Date: Tue, 15 Jun 2010 10:12:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Display all processes using ps
References: <1276385764.2972.5.camel@tesla.lan>
In-Reply-To: <1276385764.2972.5.camel@tesla.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/12/2010 07:36 PM, Guido Trentalancia wrote:
> Hello everybody !
>
> I am logging as root on a remote MLS machine using ssh so the default
> role is staff_r. However, I need to execute ps (to display all system
> processes, "ps -ax") over ssh. Unfortunately, ps does not show all
> processes that are normally displayed when using the sysadm_r role
> because it runs in the staff_r role.
>
> What would be the safest way to allow ps over ssh to show all processes
> running on the system ?
>
> Thanks for your help.
>
> Guido
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

If you want to allow staff this, you need to add


mls_file_read_to_clearance(staff_t)

And make sure staff_t has SystemLow-SystemHigh

Or if you want to be more specific you could add a new constraint, like 
the one in MCS

mlsconstrain file { read ioctl lock execute execute_no_trans }
	(( h1 dom h2 ) or ( t1 == mcsreadall ) or ( t2 == domain ));

And then allow staff_t to read all process files but no others.

Or turn on the

ssh_sysadm_login boolean
and log in


ssh dwalsh/sysadm_r@remotehost


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
