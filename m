Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5IJiD6n024856
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 15:44:13 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5IJhMGC007711
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 19:43:22 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o5IJiBxC030677
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 15:44:12 -0400
Received: from localhost.localdomain (vpn-9-141.rdu.redhat.com [10.11.9.141])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o5IJiBbf005713
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 15:44:11 -0400
Message-ID: <4C1BCC8B.9000904@redhat.com>
Date: Fri, 18 Jun 2010 15:44:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: New init system hitting a distro near you.
References: <4C1BCA54.20005@redhat.com>
In-Reply-To: <4C1BCA54.20005@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/18/2010 03:34 PM, Daniel J Walsh wrote:
> http://0pointer.de/blog/projects/systemd.html
>
> This has interesting ramifications for SELinux. I have a working version
> of this in Fedora 14, but we need to add rules like
>
> allow sshd_t init_t:tcp_socket { getopt ioctl getattr setopt };
>
> Since systemd will be doing the listening and passing the socket to sshd.
>
> Could we have risks of sshd_t grabbing the tcp_socket connected to httpd_t?
>
> In this scenario we are no longer protecting against the name_bind, and
> are forced to put more trust into init_t.
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>
>


 From rudimentary testing we would have to add

ifdef(`init_systemd', `
	allow daemon init_t:socket_class_set { getopt ioctl getattr setopt };
')

Which seems to allow sshd_t to work.

I guess we could make it more secure by locking this down based on the 
name_bind macros but we also want to handle things like cups which 
listen on a unix domain socket.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
