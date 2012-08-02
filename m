Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q72JdQ5G021161
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2012 15:39:26 -0400
Received: by vcbfl17 with SMTP id fl17so9400322vcb.12
        for <selinux@tycho.nsa.gov>; Thu, 02 Aug 2012 12:39:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bfd0f6f6-f84b-409f-a347-67abb9255d5e@googlegroups.com>
References: <bfd0f6f6-f84b-409f-a347-67abb9255d5e@googlegroups.com>
Date: Thu, 2 Aug 2012 12:39:24 -0700
Message-ID: <CAFftDdrQFXwagKvOvSfzfbzb6AL=oNrsxQcMdZ2nGQiXLM7Q2w@mail.gmail.com>
Subject: Re: repo commit broke repo init
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This issue has been fixed in repo in tag v1.10.2 as of this morning.

On Thu, Aug 2, 2012 at 11:14 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> I have been using repo init on existing mirror in a script to checkout
> proper manifest versions so my local manifest files match up correctly
> for each sync operation. This currently broke in commit
> b292b98c3e9a9f666ca780ba60fdb4f306eca343
>
> Command: repo init -u https://android.googlesource.com/platform/manifest
>
> error output:
> Traceback (most recent call last):
>   File "/media/work/repo/seandroid/.repo/repo/main.py", line 385, in
> <module>
>     _Main(sys.argv[1:])
>   File "/media/work/repo/seandroid/.repo/repo/main.py", line 365, in _Main
>     result = repo._Run(argv) or 0
>   File "/media/work/repo/seandroid/.repo/repo/main.py", line 137, in _Run
>     result = cmd.Execute(copts, cargs)
>   File "/media/work/repo/seandroid/.repo/repo/subcmds/init.py", line 320, in
> Execute
>     self._LinkManifest(opt.manifest_name)
>   File "/media/work/repo/seandroid/.repo/repo/subcmds/init.py", line 208, in
> _LinkManifest
>     self.manifest.Link(name)
>   File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 109, in
> Link
>     self.Override(name)
>   File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 102, in
> Override
>     self._Load()
>   File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 301, in
> _Load
>     self._AddMetaProjectMirror(self.repoProject)
>   File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 435, in
> _AddMetaProjectMirror
>     remote = _XmlRemote('origin', m_url[:s], manifestUrl)
>   File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 53, in
> __init__
>     self.resolvedFetchUrl = self._resolveFetchUrl()
>   File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 57, in
> _resolveFetchUrl
>     manifestUrl = self.manifestUrl.rstrip('/')
> AttributeError: 'NoneType' object has no attribute 'rstrip'
>
>
> git bisect output:
> repo mirror initialized in /media/work/repo/seandroid
> b292b98c3e9a9f666ca780ba60fdb4f306eca343 is the first bad commit
> commit b292b98c3e9a9f666ca780ba60fdb4f306eca343
> Author: Yestin Sun <sunyi0804@gmail.com>
> Date:   Mon Jul 2 07:32:50 2012 -0700
>
>     Add remote alias support in manifest
>
>     The `alias` is an optional attribute in element `remote`. It can be
>     used to override attibute `name` to be set as the remote name in each
>     project's .git/config. Its value can be duplicated while attribute
>     `name` has to be unique across the manifest file. This helps each
>     project to be able to have same remote name which actually points
>     to different remote url.
>
>     It eases some automation scripts to be able to checkout/push to same
>     remote name but actually different remote url, like:
>
>     repo forall -c "git checkout -b work same_remote/work"
>     repo forall -c "git push same_remote work:work"
>
>     for example:
>     The manifest with 'alias' will look like:
>
>     <?xml version='1.0' encoding='UTF-8'?>
>     <manifest>
>       <remote alias="same_alias" fetch="git://git.external1.org/"
> name="ext1"
>           review="http://review.external1.org"/>
>       <remote alias="same_alias" fetch="git://git.external2.org/"
> name="ext2"
>           review="http://review.external2.org"/>
>       <remote alias="same_alias" fetch="ssh://git.internal.com:29418"
> name="int"
>           review="http://review.internal.com"/>
>       <default remote="int" revision="int-branch" sync-j="2"/>
>       <project name="path/to/project1" path="project1" remote="ext1"/>
>       <project name="path/to/project2" path="project2" remote="ext2"/>
>       <project name="path/to/project3" path="project3"/>
>       ...
>     </manifest>
>
>     In each project, use command "git remote -v"
>
>     project1:
>     same_alias  git://git.external1.org/project1 (fetch)
>     same_alias  git://git.external1.org/project1 (push)
>
>     project2:
>     same_alias  git://git.external2.org/project2 (fetch)
>     same_alias  git://git.external2.org/project2 (push)
>
>     project3:
>     same_alias  ssh://git.internal.com:29418/project3 (fetch)
>     same_alias  ssh://git.internal.com:29418/project3 (push)
>
>     Change-Id: I2c48263097ff107f0c978f3e83966ae71d06cb90
>
> :040000 040000 5eaed1fdfb1f3117e0b67b56caceb79ec1207c42
> 2c3a61288301b15499cf6aa0f002ebfc9e2f0717 M docs
> :100644 100644 86899f63a6c740e8b6e2e1616b64038453a95d21
> d3156e5ce8de2ccc39b8981a6505723b11c12090 M manifest_xml.py
> bisect run success
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
