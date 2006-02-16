Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1GEtsXf027629
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 09:55:54 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1GEsUTW010135
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 14:54:30 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: linux-audit@redhat.com
Subject: Re: [RFC][PATCH] collect security labels on user processes generating audit messages
Date: Thu, 16 Feb 2006 09:56:19 -0500
Cc: Linda Knippers <linda.knippers@hp.com>, James Morris <jmorris@namei.org>,
   selinux@tycho.nsa.gov
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com> <43F36244.7040000@hp.com> <200602151320.51016.sgrubb@redhat.com>
In-Reply-To: <200602151320.51016.sgrubb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602160956.20357.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 15 February 2006 13:20, Steve Grubb wrote:
> > type=PATH msg=audit(1140192875.311:3789): name="(null)" flags=1
> > inode=6537222 dev=fd:01 mode=0100664 ouid=501 ogid=501 rdev=00:00
>
> Wait a second...notice the quote marks around (null). When you have a
> genuine (null) they are not there.
>
> type=PATH msg=audit(02/14/2006 08:54:27.096:24) : item=1 name=(null)
> inode=34681 dev=03:06 mode=dir,700 ouid=root ogid=root rdev=00:00
> obj=system_u:object_r:automount_tmp_t:s0

OK, I chased this down to make sure of what is happening. The audit working 
group has a test kernel, lspp.8, that has all the future audit and lspp 
patches in it for testing. (it can be found at 
http://people.redhat.com/sgrubb/files/lspp). There is a patch 
linux-2.6-audit-git.patch, which is not upstream, but should be in the next 
kernel. That changes the code in audit_log_exit of auditsc.c to:

                if (context->names[i].name)
                        audit_log_untrustedstring(ab, context->names[i].name);
                else
                        audit_log_format(ab, "(null)");

The code in audit_log_untrustedstring does this:

        while (*p) {
                if (*p == '"' || *p == '(' || *p < 0x21 || *p > 0x7f) {
                        audit_log_hex(ab, string, strlen(string));
                        return;
                }
                p++;
        }
        audit_log_format(ab, "\"%s\"", string);

This means that a real NULL will never have the double-quote marks around it, 
where a file named \(null\) will always have double-quote marks around it. I 
confirmed this by looking in the audit logs. 

However...ausearch does not make this distinction in its output. I will see 
what I can do to make the necessary adjustments to ausearch so that its more 
obvious. So, I think that puts this issue to bed...

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
