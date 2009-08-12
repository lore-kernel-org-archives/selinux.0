Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7CLA0K6029847
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 17:10:00 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n7CLB3db020426
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 21:11:04 GMT
Date: Wed, 12 Aug 2009 17:09:58 -0400
Subject: Re: Patch to semanage
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C6A8A7E6.A9A90%csellers@tresys.com>
In-Reply-To: <4A604E1D.2020202@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/17/09 6:10 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> Ok lets try the patch again.
> 
> Added equal patch (spelled correctly.)
> Beginning to add modules support to consolidate on one management command.
> Eventually replace semodule/setsebool with semanage command.
> Some white space fixing in seobject.py

I've split this patch into the 3 separate patches (whitespace, equal,
modules) for review purposes, as it was too difficult to get through with
the 3 different patches interspersed. Please try to split up functional
patches in the future.

This message will apply to the equal patch only.

> diff --git a/policycoreutils/semanage/seobject.py
> b/policycoreutils/semanage/seobject.py
> index d3e0c40..94bdf7f 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -1408,6 +1408,48 @@ class interfaceRecords(semanageRecords):
>  class fcontextRecords(semanageRecords):
>      def __init__(self, store = ""):
>          semanageRecords.__init__(self, store)
> +        self.equiv = {}
> +        self.equal_ind = False
> +        try:
> +            fd = open(selinux.selinux_file_context_subs_path(), "r")
> +            for i in fd.readlines():
> +                src, dst = i.split()
> +                self.equiv[src] = dst
> +            fd.close()
> +                except IOError:
> +            pass
> +
> +    def commit(self):
> +        if self.equal_ind:
> +            subs_file = selinux.selinux_file_context_subs_path()
> +            tmpfile = "%s.tmp" % subs_file
> +            fd = open(tmpfile, "w")
> +            for src in self.equiv.keys():
> +                fd.write("%s %s\n" % (src, self.equiv[src]))
> +            fd.close()
> +            try:
> +                os.chmod(tmpfile, os.stat(subs_file)[stat.ST_MODE])
> +            except:
> +                pass
> +            os.rename(tmpfile,subs_file)
> +            self.equal_ind = False
> +        semanageRecords.commit(self)
> +
Using subs in this manner has interesting side-effects, as all subs does is
string substitution before looking up the context. This can result in
weirdness when the string is passed to the regex matcher, such as:

1. Regular files will not match directory entries (/foo is a regular file):
[root@f10 selinux]# semanage fcontext -a -e /usr /foo
[root@f10 selinux]# restorecon -nv /foo
restorecon reset /foo context
unconfined_u:object_r:user_home_t:s0->system_u:object_r:etc_runtime_t:s0

2. Regular expression matching can cause matches to depend on whether a / is
appended:
[root@f10 selinux]# semanage fcontext -a -e /usr/ /foo
[root@f10 selinux]# restorecon -nv /foo
restorecon reset /foo context
unconfined_u:object_r:user_home_t:s0->system_u:object_r:usr_t:s0

<snip>

Unfortunately, I don't see an easy fix to these problems. We could augment
the subs functionality to allow the user to specify the kind of file they
want to match, but that would just make things more complex in trying to
work around the problem. Or, we could just decide to live with the
peculiarities (and at least document them for people who get confused).

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
