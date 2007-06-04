Subject: Re: Apache and PHP
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <B10330AA-511A-4F34-BED6-C129EF5868B6@sf-net.com>
References: <40E6CEE4-6DFE-4458-8DB7-11D81DFC7E80@sf-net.com>
	 <B10330AA-511A-4F34-BED6-C129EF5868B6@sf-net.com>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 09:17:46 -0400
Message-Id: <1180963066.14220.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-06-03 at 16:56 +0200, Stefan Schulze Frielinghaus wrote:
> On 02.06.2007, at 15:44, Stefan Schulze Frielinghaus wrote:
> > I labeled the files correctly and enabled the apache_enable_cgi  
> > boolean, but I still get some AVC errors:
> >
> > # dmesg -c | audit2allow
> > allow httpd_t httpd_dokuwiki_content_t:dir { getattr read search };
> > allow httpd_t httpd_dokuwiki_content_t:file { getattr read };
> > allow httpd_t httpd_dokuwiki_script_rw_t:dir { getattr search write };
> > allow httpd_t httpd_dokuwiki_script_rw_t:file { getattr read write };
> 
> OK like from http://fedoraproject.org/wiki/SELinux/apache I haven't  
> enabled httpd_builtin_scripting. After that no AVCs are generated.  
> But if you look at the policy (refpolicy-20061212) there are still  
> some questions left. For example at the section (line 128)  
> "tunable_policy(`httpd_builtin_scripting',`" there are many entries  
> which allow the httpd_t domain to do what ever it wants with the  
> httpd_$1_script_rw_t types:
> 
> manage_files_pattern(httpd_t,httpd_$1_script_rw_t,httpd_$1_script_rw_t)
> 
> This means to me that if the apache webserver gets compromised all my  
> files which are labeled httpd_$1_script_rw_t could be damaged. I  
> thought I could secure my PHP applications so that the only access to  
> the PHP files is via the httpd_$1_script_t domain.
> Is this really the deserved behavior for PHP applications running  
> under SELinux or did I miss something? I'm not really sure how to  
> interpret the message from the wiki:
> 
> httpd can be configured to turn off internal scripting (PHP).  PHP   
> and other
> loadable modules run under the same context as httpd.  Therefore
> several  policy  rules  allow httpd greater access to the system
> then is needed if you only use external cgi scripts.
> setsebool -P httpd_builtin_scripting 0
> 
> Does this mean that all PHP applications can't be distinct between  
> httpd_t and the httpd_$1_script_t?

Correct, unless you run them via a CGI such that one can transition them
upon the execve.  Or, you could construct an apache module that does a
dynamic context transition, i.e. setcon(3), around the execution of the
PHP code, such that it runs in a different domain, but that is a weak
boundary, unlike the exec-based one.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
