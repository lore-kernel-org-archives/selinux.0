Subject: Re: strange pam_selinux behavior
To: Dominick Grift <dac.override@gmail.com>,
 Daniel J Walsh <dwalsh@redhat.com>, Miroslav Grepl <mgrepl@redhat.com>,
 selinux@tycho.nsa.gov
References: <56F2D938.8030909@gmail.com> <56F2E136.6090304@gmail.com>
 <56F2E276.9070702@gmail.com> <56F2E999.1070904@tycho.nsa.gov>
 <56F2E9F0.7040905@gmail.com> <56F2F163.5060309@gmail.com>
 <56F3E833.4090504@redhat.com> <56F3EA88.1020703@gmail.com>
 <56F3EBEF.7050808@redhat.com> <56F3FA39.6080003@gmail.com>
 <56F4512A.8080507@redhat.com> <56F56129.3080509@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56F567F2.8030507@tycho.nsa.gov>
Date: Fri, 25 Mar 2016 12:31:46 -0400
MIME-Version: 1.0
In-Reply-To: <56F56129.3080509@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/25/2016 12:02 PM, Dominick Grift wrote:
> I set out to try mcstransd again today. After doing to searching i
> found a clue about the requirement to add accesscheck=1 to
> setrans.conf to at least enable checking of the translate av perm.
> 
> So i added a few auditallow rules that should catch at least some
> checks however: nothing shows up in the logs.
> 
> Either i am overlooking something or the mcstransd object manager is
> broken

Yes, I mentioned the lack of this access check in
http://article.gmane.org/gmane.comp.security.selinux/22011

However, the mcscolor code within mcstrans still does a check of the
context contains permission.  This is only exercised if something calls
selinux_raw_context_to_color() in libselinux, and if one has a
secolor.conf.  That was added for SELinux-aware graphical applications
which display security contexts in order to associate color schemes with
security contexts.

Likely unused in Fedora but may be used in various MLS desktop solutions
built on SELinux.
