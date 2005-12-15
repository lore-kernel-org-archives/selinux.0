Subject: Re: RHES4, Subversion, Apache and SElinux
From: Tobias Nijweide <tobias@neatech.nl>
To: SELinux@tycho.nsa.gov
In-Reply-To: <6c18a4f0512151401p3948e810g5bec34eabbce522c@mail.gmail.com>
References: <6c18a4f0512151401p3948e810g5bec34eabbce522c@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 23:57:09 +0100
Message-Id: <1134687429.15362.16.camel@nachtwacht>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-12-15 at 23:01 +0100, Bernd Bartmann wrote:
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

Apparently '/data' is of type system_u:object_r:file_t. Before httpd can
access any of the repository files it has to read /, /data, /data/Devel
and /data/Devel/SVN. 3 options:
- Make those dirs of types that httpd_t can search as well.
- Add permission for httpd_t to search directories of type file_t.
- Create a new type, and add permission for httpd_t to search that type.

When changing default policy, it can help a lot to put all of it in a
source repository (SVN? :) because otherwise it's too easy to lose track
of what you changed, and to add your changes back in after you install
the next RH policy.

Good luck,
Tobias Nijweide




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
