Subject: Re: unified_type patch for apache.
From: Colin Walters <walters@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Russell Coker <rcoker@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41756DB7.8070704@redhat.com>
References: <41756DB7.8070704@redhat.com>
Content-Type: text/plain
Date: Tue, 19 Oct 2004 15:58:37 -0400
Message-Id: <1098215917.27218.27.camel@decepticon.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-19 at 15:40 -0400, Daniel J Walsh wrote:
>  So setting unified_apache will make all content 
> the same and fall back to DAC as far as cgi executables. 

Just to be clear though, CGI script executables still run as
httpd_sys_script_t, which is very useful when using suexec, where CGI
scripts run as the user's UID.  I think this is a fairly common setup
with Apache.  In this case, a CGI doesn't have permission to e.g. read
or write files in the user's home directory or kill off other processes
you might be running like your login shell.  So there's still a lot of
security gained even with the unified_apache boolean turned on in this
case.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
