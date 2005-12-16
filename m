Message-ID: <43A20913.1080104@cmcrc.com>
Date: Fri, 16 Dec 2005 11:23:47 +1100
From: Johan Fischer <jfischer@cmcrc.com>
MIME-Version: 1.0
To: Bernd Bartmann <bernd.bartmann@gmail.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: RHES4, Subversion, Apache and SElinux
References: <6c18a4f0512151401p3948e810g5bec34eabbce522c@mail.gmail.com>
In-Reply-To: <6c18a4f0512151401p3948e810g5bec34eabbce522c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Seems to me that your partition /data is not with a se context that
httpd_t can search/read/getattr (which is file_t),

If you don't have anything else selinux sensitive in /data (used by
another process under a different context), just chcon the all /data.

In a more detailed way, If I remember, the default_t context is readable
by httpd_t, so just change the /data, /data/Devel and /data/Devel/SVN to
default_t.

Cheers.
J.

Bernd Bartmann wrote:

>Hi,
>
>I try to setup some Subversion repositories using Apache on a RHES4
>server. Now I'm running into a problem with Apache and SElinux.
>
>My SVNParentPath is set to /data/Devel/SVN/repos. /data is on
>/dev/md5. I already followed the "How do I set repository permissions
>correctly?" FAQ from http://subversion.tigris.org/faq.html and issued
>a "chcon -R -h -t httpd_sys_content_t /data/Devel/SVN/repos/", but
>whenever I try to access the contents of my Subversion repo I this in
>/var/log/messages:
>
>avc:  denied  { search } for  pid=10337 comm="httpd" name="/" dev=md5
>ino=2 scontext=root:system_r:httpd_t tcontext=system_u:object_r:file_t
>tclass=dir
>
>Any ideas?
>
>Thanks in advance,
>Bernd.
>
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>

-- 
Johan Fischer
Capital Markets CRC Limited
Level 2, 9 Castlereagh Street, Sydney NSW 2000
Tel: +61 2 9233 7999   Direct: +61 2 9236 9150
Fax: +61 2 9236 9177   http://www.cmcrc.com

Capital Markets CRC Ltd (CMCRC) - Confidential Communication
The information contained in this e-mail is confidential.  It is intended solely for the addressee. If you receive this e-mail by mistake please promptly inform us by reply e-mail and then delete the e-mail and destroy any printed copy. You must not disclose or use in any way the information in the e-mail. There is no warranty that this e-mail is error or virus free. It may be a private communication, and if so, does not represent the views of the CMCRC and its associates. If it is a private communication, care should be taken in opening it to ensure that undue offence is not given.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
