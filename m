Message-ID: <4242B3BD.3060707@ak.jp.nec.com>
Date: Thu, 24 Mar 2005 21:34:05 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC & PATCH] inherited type definition.
References: <4236CC03.5010104@kaigai.gr.jp> <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil> <4237B950.2090604@ak.jp.nec.com> <1110981928.4802.81.camel@moss-spartans.epoch.ncsc.mil> <42394ECA.7010204@ak.jp.nec.com> <1111067742.8664.31.camel@moss-spartans.epoch.ncsc.mil> <42399AE4.5040508@kaigai.gr.jp> <423E9CFF.3080808@kaigai.gr.jp> <1111420782.13101.16.camel@moss-spartans.epoch.ncsc.mil> <42412635.4030108@ak.jp.nec.com> <20050324110634.GD13372@lkcl.net>
In-Reply-To: <20050324110634.GD13372@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

 >>o And, private additional configuration is as follows:
 >>--- /dev/null   2005-03-22 18:46:01.562514976 -0500
 >>+++ policy.kaigai/inaddition.te 2005-03-23 04:06:49.576548144 -0500
 >>@@ -0,0 +1,7 @@
 >>+# necessity for access path
 >>+typeattribute var_t ftp_content_path, samba_share_path;
 >>+typeattribute httpd_sys_content_t ftp_content_path, samba_share_path;
 >>+# definition of unified file type
 >>+type httpd_ftp_t extends httpd_sys_content_t, ftp_content_t;
 >>+type httpd_samba_t extends httpd_sys_content_t, samba_share_t;
 >
 >  ... what's the difference between attribute and typeattribute?

There are two differences between attribute and inherited type.
1) We can use source types directly such as httpd_sys_content_t.
    If these are declared as attribute, we have to define one more
    type which is attached those attributes.
2) When httpd_samba_t has a child type labeled httpd_samba_ftp_t and accessed
    via Apache, Samba and FTP, the definition of type needs to inherit only
    httpd_samba_t and ftp_content_t as an additional type.
    If those are defined as attributes, httpd_samba_ftp_t have to inherit
    all of these attributes.

The benefit of EXTENDS comparing with ATTRIBUTE may be uncertainness
for two-layer structure, but it's obviously for multi-layer structure,I think.

e.g,
When we try to define /home/foo labeled foo_home_t accessed via Samba and FTP,
and /home/foo/public_html labeled foo_public_html_t accessed vis Apache in addition,
we must append all attributes for each type, if thoes are defined as attribute.
If we can use EXTENDS statements, foo_public_html_t only have to inherit foo_home_t
and pre-defined type for HTML contents.

Thanks,
-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
