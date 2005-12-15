Message-ID: <43A1F9DC.3010205@redhat.com>
Date: Thu, 15 Dec 2005 18:18:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Bernd Bartmann <bernd.bartmann@gmail.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: RHES4, Subversion, Apache and SElinux
References: <6c18a4f0512151401p3948e810g5bec34eabbce522c@mail.gmail.com>
In-Reply-To: <6c18a4f0512151401p3948e810g5bec34eabbce522c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Bernd Bartmann wrote:
> Hi,
>
> I try to setup some Subversion repositories using Apache on a RHES4
> server. Now I'm running into a problem with Apache and SElinux.
>
> My SVNParentPath is set to /data/Devel/SVN/repos. /data is on
> /dev/md5. I already followed the "How do I set repository permissions
> correctly?" FAQ from http://subversion.tigris.org/faq.html and issued
> a "chcon -R -h -t httpd_sys_content_t /data/Devel/SVN/repos/", but
> whenever I try to access the contents of my Subversion repo I this in
> /var/log/messages:
>
> avc:  denied  { search } for  pid=10337 comm="httpd" name="/" dev=md5
> ino=2 scontext=root:system_r:httpd_t tcontext=system_u:object_r:file_t
> tclass=dir
>
> Any ideas?
>
> Thanks in advance,
> Bernd.
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>   
file_t indicates that the file system was never labeled.

try chcon -R -t httpd_sys_content_t /data

to label the entire tree.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
