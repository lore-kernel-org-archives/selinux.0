Message-ID: <1489179435.6824.59.camel@tycho.nsa.gov>
Subject: Re: [PATCH] Python 3.6 invalid escape sequence deprecation fixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, Ville =?ISO-8859-1?Q?Skytt=E4?=
 <ville.skytta@iki.fi>, selinux@tycho.nsa.gov
Date: Fri, 10 Mar 2017 15:57:15 -0500
In-Reply-To: <e58141ef-cc49-917a-5a0b-3186e67e9982@redhat.com>
References: <20170309090935.22458-1-ville.skytta@iki.fi>
 <e58141ef-cc49-917a-5a0b-3186e67e9982@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-03-09 at 15:09 +0100, Petr Lautrbach wrote:
> On 03/09/2017 10:09 AM, Ville Skyttä wrote:
> > 
> > https://docs.python.org/3/whatsnew/3.6.html#deprecated-python-behav
> > ior
> 
> 
> I'd suggest to add the text from the page directly to the commit
> message:
> 
> A backslash-character pair that is not a valid escape sequence now
> generates a DeprecationWarning. Although this will eventually become
> a
> SyntaxError, that will not be for several Python releases.
> 
> 
> The problem appears when you use '-W error':
> 
> $ python3 -W error -c 'import re; re.findall("[^a-zA-Z0-9_\-\.]", "
> *%$")'
>   File "<string>", line 1
> SyntaxError: invalid escape sequence \-
> 
> 
> > 
> > Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>

Thanks, applied with edited commit message.

> > ---
> >  python/semanage/seobject.py            | 4 ++--
> >  python/sepolgen/src/sepolgen/module.py | 2 +-
> >  python/sepolicy/sepolicy/generate.py   | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/python/semanage/seobject.py
> > b/python/semanage/seobject.py
> > index c836cc5..94bd368 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -192,8 +192,8 @@ class nulllogger:
> >  def validate_level(raw):
> >      sensitivity = "s[0-9]*"
> >      category = "c[0-9]*"
> > -    cat_range = category + "(\." + category + ")?"
> > -    categories = cat_range + "(\," + cat_range + ")*"
> > +    cat_range = category + r"(\." + category + ")?"
> > +    categories = cat_range + r"(\," + cat_range + ")*"
> >      reg = sensitivity + "(-" + sensitivity + ")?" + "(:" +
> > categories + ")?"
> >      return re.search("^" + reg + "$", raw)
> >  
> > diff --git a/python/sepolgen/src/sepolgen/module.py
> > b/python/sepolgen/src/sepolgen/module.py
> > index c09676a..8766dd9 100644
> > --- a/python/sepolgen/src/sepolgen/module.py
> > +++ b/python/sepolgen/src/sepolgen/module.py
> > @@ -40,7 +40,7 @@ from . import defaults
> >  def is_valid_name(modname):
> >      """Check that a module name is valid.
> >      """
> > -    m = re.findall("[^a-zA-Z0-9_\-\.]", modname)
> > +    m = re.findall(r"[^a-zA-Z0-9_\-\.]", modname)
> >      if len(m) == 0 and modname[0].isalpha():
> >          return True
> >      else:
> > diff --git a/python/sepolicy/sepolicy/generate.py
> > b/python/sepolicy/sepolicy/generate.py
> > index 5696110..596891a 100644
> > --- a/python/sepolicy/sepolicy/generate.py
> > +++ b/python/sepolicy/sepolicy/generate.py
> > @@ -1329,7 +1329,7 @@ allow %s_t %s_t:%s_socket name_%s;
> >              self.add_dir("/var/lib/%s" % self.name)
> >  
> >          if os.path.isfile("/etc/rc.d/init.d/%s" % self.name):
> > -            self.set_init_script("/etc/rc\.d/init\.d/%s" %
> > self.name)
> > +            self.set_init_script(r"/etc/rc\.d/init\.d/%s" %
> > self.name)
> >  
> >          # we don't want to have subdir in the .fc policy file
> >          # if we already specify labeling for parent dir
> > 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho
> .nsa.gov.
