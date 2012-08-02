Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q72IE2Th017213
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2012 14:14:02 -0400
Received: by ghbz19 with SMTP id z19so9432152ghb.24
        for <selinux@tycho.nsa.gov>; Thu, 02 Aug 2012 11:14:01 -0700 (PDT)
Date: Thu, 2 Aug 2012 11:14:00 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: android-building@googlegroups.com
Cc: selinux@tycho.nsa.gov
Message-Id: <bfd0f6f6-f84b-409f-a347-67abb9255d5e@googlegroups.com>
Subject: repo commit broke repo init
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_20_7351184.1343931240771"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_20_7351184.1343931240771
Content-Type: multipart/alternative;
	boundary="----=_Part_21_3936436.1343931240771"

------=_Part_21_3936436.1343931240771
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I have been using repo init on existing mirror in a script to checkout 
proper manifest versions so my local manifest files match up correctly
for each sync operation. This currently broke in 
commit b292b98c3e9a9f666ca780ba60fdb4f306eca343

Command: repo init -u https://android.googlesource.com/platform/manifest

error output:
Traceback (most recent call last):
  File "/media/work/repo/seandroid/.repo/repo/main.py", line 385, in 
<module>
    _Main(sys.argv[1:])
  File "/media/work/repo/seandroid/.repo/repo/main.py", line 365, in _Main
    result = repo._Run(argv) or 0
  File "/media/work/repo/seandroid/.repo/repo/main.py", line 137, in _Run
    result = cmd.Execute(copts, cargs)
  File "/media/work/repo/seandroid/.repo/repo/subcmds/init.py", line 320, 
in Execute
    self._LinkManifest(opt.manifest_name)
  File "/media/work/repo/seandroid/.repo/repo/subcmds/init.py", line 208, 
in _LinkManifest
    self.manifest.Link(name)
  File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 109, 
in Link
    self.Override(name)
  File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 102, 
in Override
    self._Load()
  File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 301, 
in _Load
    self._AddMetaProjectMirror(self.repoProject)
  File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 435, 
in _AddMetaProjectMirror
    remote = _XmlRemote('origin', m_url[:s], manifestUrl)
  File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 53, in 
__init__
    self.resolvedFetchUrl = self._resolveFetchUrl()
  File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 57, in 
_resolveFetchUrl
    manifestUrl = self.manifestUrl.rstrip('/')
AttributeError: 'NoneType' object has no attribute 'rstrip'


git bisect output:
repo mirror initialized in /media/work/repo/seandroid
b292b98c3e9a9f666ca780ba60fdb4f306eca343 is the first bad commit
commit b292b98c3e9a9f666ca780ba60fdb4f306eca343
Author: Yestin Sun <sunyi0804@gmail.com>
Date:   Mon Jul 2 07:32:50 2012 -0700

    Add remote alias support in manifest
    
    The `alias` is an optional attribute in element `remote`. It can be
    used to override attibute `name` to be set as the remote name in each
    project's .git/config. Its value can be duplicated while attribute
    `name` has to be unique across the manifest file. This helps each
    project to be able to have same remote name which actually points
    to different remote url.
    
    It eases some automation scripts to be able to checkout/push to same
    remote name but actually different remote url, like:
    
    repo forall -c "git checkout -b work same_remote/work"
    repo forall -c "git push same_remote work:work"
    
    for example:
    The manifest with 'alias' will look like:
    
    <?xml version='1.0' encoding='UTF-8'?>
    <manifest>
      <remote alias="same_alias" fetch="git://git.external1.org/" 
name="ext1"
          review="http://review.external1.org"/>
      <remote alias="same_alias" fetch="git://git.external2.org/" 
name="ext2"
          review="http://review.external2.org"/>
      <remote alias="same_alias" fetch="ssh://git.internal.com:29418" 
name="int"
          review="http://review.internal.com"/>
      <default remote="int" revision="int-branch" sync-j="2"/>
      <project name="path/to/project1" path="project1" remote="ext1"/>
      <project name="path/to/project2" path="project2" remote="ext2"/>
      <project name="path/to/project3" path="project3"/>
      ...
    </manifest>
    
    In each project, use command "git remote -v"
    
    project1:
    same_alias  git://git.external1.org/project1 (fetch)
    same_alias  git://git.external1.org/project1 (push)
    
    project2:
    same_alias  git://git.external2.org/project2 (fetch)
    same_alias  git://git.external2.org/project2 (push)
    
    project3:
    same_alias  ssh://git.internal.com:29418/project3 (fetch)
    same_alias  ssh://git.internal.com:29418/project3 (push)
    
    Change-Id: I2c48263097ff107f0c978f3e83966ae71d06cb90

:040000 040000 5eaed1fdfb1f3117e0b67b56caceb79ec1207c42 
2c3a61288301b15499cf6aa0f002ebfc9e2f0717 M docs
:100644 100644 86899f63a6c740e8b6e2e1616b64038453a95d21 
d3156e5ce8de2ccc39b8981a6505723b11c12090 M manifest_xml.py
bisect run success


------=_Part_21_3936436.1343931240771
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div>I have been using repo init on existing mirror in a script to checkout=
 proper manifest versions so my local manifest files match up correctly</di=
v><div>for each sync operation. This currently broke in commit&nbsp;b292b98=
c3e9a9f666ca780ba60fdb4f306eca343</div><div><br></div><div>Command:&nbsp;re=
po init -u https://android.googlesource.com/platform/manifest</div><div><br=
></div><div>error output:</div><div><div>Traceback (most recent call last):=
</div><div>&nbsp; File "/media/work/repo/seandroid/.repo/repo/main.py", lin=
e 385, in &lt;module&gt;</div><div>&nbsp; &nbsp; _Main(sys.argv[1:])</div><=
div>&nbsp; File "/media/work/repo/seandroid/.repo/repo/main.py", line 365, =
in _Main</div><div>&nbsp; &nbsp; result =3D repo._Run(argv) or 0</div><div>=
&nbsp; File "/media/work/repo/seandroid/.repo/repo/main.py", line 137, in _=
Run</div><div>&nbsp; &nbsp; result =3D cmd.Execute(copts, cargs)</div><div>=
&nbsp; File "/media/work/repo/seandroid/.repo/repo/subcmds/init.py", line 3=
20, in Execute</div><div>&nbsp; &nbsp; self._LinkManifest(opt.manifest_name=
)</div><div>&nbsp; File "/media/work/repo/seandroid/.repo/repo/subcmds/init=
.py", line 208, in _LinkManifest</div><div>&nbsp; &nbsp; self.manifest.Link=
(name)</div><div>&nbsp; File "/media/work/repo/seandroid/.repo/repo/manifes=
t_xml.py", line 109, in Link</div><div>&nbsp; &nbsp; self.Override(name)</d=
iv><div>&nbsp; File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py"=
, line 102, in Override</div><div>&nbsp; &nbsp; self._Load()</div><div>&nbs=
p; File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py", line 301, =
in _Load</div><div>&nbsp; &nbsp; self._AddMetaProjectMirror(self.repoProjec=
t)</div><div>&nbsp; File "/media/work/repo/seandroid/.repo/repo/manifest_xm=
l.py", line 435, in _AddMetaProjectMirror</div><div>&nbsp; &nbsp; remote =
=3D _XmlRemote('origin', m_url[:s], manifestUrl)</div><div>&nbsp; File "/me=
dia/work/repo/seandroid/.repo/repo/manifest_xml.py", line 53, in __init__</=
div><div>&nbsp; &nbsp; self.resolvedFetchUrl =3D self._resolveFetchUrl()</d=
iv><div>&nbsp; File "/media/work/repo/seandroid/.repo/repo/manifest_xml.py"=
, line 57, in _resolveFetchUrl</div><div>&nbsp; &nbsp; manifestUrl =3D self=
.manifestUrl.rstrip('/')</div><div>AttributeError: 'NoneType' object has no=
 attribute 'rstrip'</div></div><div><br></div><br><div>git bisect output:</=
div><div><div>repo mirror initialized in /media/work/repo/seandroid</div><d=
iv>b292b98c3e9a9f666ca780ba60fdb4f306eca343 is the first bad commit</div><d=
iv>commit b292b98c3e9a9f666ca780ba60fdb4f306eca343</div><div>Author: Yestin=
 Sun &lt;sunyi0804@gmail.com&gt;</div><div>Date: &nbsp; Mon Jul 2 07:32:50 =
2012 -0700</div><div><br></div><div>&nbsp; &nbsp; Add remote alias support =
in manifest</div><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; &nbsp; The `alia=
s` is an optional attribute in element `remote`. It can be</div><div>&nbsp;=
 &nbsp; used to override attibute `name` to be set as the remote name in ea=
ch</div><div>&nbsp; &nbsp; project's .git/config. Its value can be duplicat=
ed while attribute</div><div>&nbsp; &nbsp; `name` has to be unique across t=
he manifest file. This helps each</div><div>&nbsp; &nbsp; project to be abl=
e to have same remote name which actually points</div><div>&nbsp; &nbsp; to=
 different remote url.</div><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; &nbsp=
; It eases some automation scripts to be able to checkout/push to same</div=
><div>&nbsp; &nbsp; remote name but actually different remote url, like:</d=
iv><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; &nbsp; repo forall -c "git che=
ckout -b work same_remote/work"</div><div>&nbsp; &nbsp; repo forall -c "git=
 push same_remote work:work"</div><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp;=
 &nbsp; for example:</div><div>&nbsp; &nbsp; The manifest with 'alias' will=
 look like:</div><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; &nbsp; &lt;?xml =
version=3D'1.0' encoding=3D'UTF-8'?&gt;</div><div>&nbsp; &nbsp; &lt;manifes=
t&gt;</div><div>&nbsp; &nbsp; &nbsp; &lt;remote alias=3D"same_alias" fetch=
=3D"git://git.external1.org/" name=3D"ext1"</div><div>&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; review=3D"http://review.external1.org"/&gt;</div><div>&nbsp; =
&nbsp; &nbsp; &lt;remote alias=3D"same_alias" fetch=3D"git://git.external2.=
org/" name=3D"ext2"</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; review=3D"=
http://review.external2.org"/&gt;</div><div>&nbsp; &nbsp; &nbsp; &lt;remote=
 alias=3D"same_alias" fetch=3D"ssh://git.internal.com:29418" name=3D"int"</=
div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; review=3D"http://review.interna=
l.com"/&gt;</div><div>&nbsp; &nbsp; &nbsp; &lt;default remote=3D"int" revis=
ion=3D"int-branch" sync-j=3D"2"/&gt;</div><div>&nbsp; &nbsp; &nbsp; &lt;pro=
ject name=3D"path/to/project1" path=3D"project1" remote=3D"ext1"/&gt;</div>=
<div>&nbsp; &nbsp; &nbsp; &lt;project name=3D"path/to/project2" path=3D"pro=
ject2" remote=3D"ext2"/&gt;</div><div>&nbsp; &nbsp; &nbsp; &lt;project name=
=3D"path/to/project3" path=3D"project3"/&gt;</div><div>&nbsp; &nbsp; &nbsp;=
 ...</div><div>&nbsp; &nbsp; &lt;/manifest&gt;</div><div>&nbsp; &nbsp;&nbsp=
;</div><div>&nbsp; &nbsp; In each project, use command "git remote -v"</div=
><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; &nbsp; project1:</div><div>&nbsp=
; &nbsp; same_alias &nbsp;git://git.external1.org/project1 (fetch)</div><di=
v>&nbsp; &nbsp; same_alias &nbsp;git://git.external1.org/project1 (push)</d=
iv><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; &nbsp; project2:</div><div>&nb=
sp; &nbsp; same_alias &nbsp;git://git.external2.org/project2 (fetch)</div><=
div>&nbsp; &nbsp; same_alias &nbsp;git://git.external2.org/project2 (push)<=
/div><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; &nbsp; project3:</div><div>&=
nbsp; &nbsp; same_alias &nbsp;ssh://git.internal.com:29418/project3 (fetch)=
</div><div>&nbsp; &nbsp; same_alias &nbsp;ssh://git.internal.com:29418/proj=
ect3 (push)</div><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; &nbsp; Change-Id=
: I2c48263097ff107f0c978f3e83966ae71d06cb90</div><div><br></div><div>:04000=
0 040000 5eaed1fdfb1f3117e0b67b56caceb79ec1207c42 2c3a61288301b15499cf6aa0f=
002ebfc9e2f0717 M<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
=09</span>docs</div><div>:100644 100644 86899f63a6c740e8b6e2e1616b64038453a=
95d21 d3156e5ce8de2ccc39b8981a6505723b11c12090 M<span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">=09</span>manifest_xml.py</div><div>bisect ru=
n success</div></div><div><br></div>
------=_Part_21_3936436.1343931240771--

------=_Part_20_7351184.1343931240771--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
