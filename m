Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAFDLcsM014723
 for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2017 08:21:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A203EC0587FC
 for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2017 13:21:30 +0000 (UTC)
Date: Wed, 15 Nov 2017 14:21:27 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <20171115132126.GB4687@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <20171110152844.32037-1-vmojzis@redhat.com>
 <20171113085626.5636-1-vmojzis@redhat.com>
 <20171114083353.GA26700@pl-rpi.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171114083353.GA26700@pl-rpi.tpb.lab.eng.brq.redhat.com>
Subject: Re: [PATCH] python/semanage: Update Infiniband code to work on python3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Nov 14, 2017 at 09:33:54AM +0100, Petr Lautrbach wrote:
> On Mon, Nov 13, 2017 at 09:56:26AM +0100, Vit Mojzis wrote:
> > Update Infiniband "port" and "key" listing and export to work on
> > python3.
> > {}.keys() does not support .sort() operation on Py3.
> > 
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> 
> Both patches look good to me. I'll merge them tomorrow if there's no
> other comments.
> 

Merged. Thanks!

> 
> 
> > ---
> >  python/semanage/seobject.py | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> > index 380256b..770745e 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -1543,9 +1543,8 @@ class ibpkeyRecords(semanageRecords):
> >      def customized(self):
> >          l = []
> >          ddict = self.get_all(True)
> > -        keys = ddict.keys()
> > -        keys.sort()
> > -        for k in keys:
> > +
> > +        for k in sorted(ddict.keys()):
> >              if k[0] == k[1]:
> >                  l.append("-a -t %s -x %s %s" % (ddict[k][0], k[2], k[0]))
> >              else:
> > @@ -1557,11 +1556,10 @@ class ibpkeyRecords(semanageRecords):
> >          keys = ddict.keys()
> >          if len(keys) == 0:
> >              return
> > -        keys.sort()
> >  
> >          if heading:
> >              print("%-30s %-18s %s\n" % (_("SELinux IB Pkey Type"), _("Subnet_Prefix"), _("Pkey Number")))
> > -        for i in keys:
> > +        for i in sorted(keys):
> >              rec = "%-30s %-18s " % i
> >              rec += "%s" % ddict[i][0]
> >              for p in ddict[i][1:]:
> > @@ -1785,9 +1783,8 @@ class ibendportRecords(semanageRecords):
> >      def customized(self):
> >          l = []
> >          ddict = self.get_all(True)
> > -        keys = ddict.keys()
> > -        keys.sort()
> > -        for k in keys:
> > +
> > +        for k in sorted(ddict.keys()):
> >              l.append("-a -t %s -r %s -z %s %s" % (ddict[k][0], ddict[k][1], k[1], k[0]))
> >          return l
> >  
> > @@ -1796,11 +1793,10 @@ class ibendportRecords(semanageRecords):
> >          keys = ddict.keys()
> >          if len(keys) == 0:
> >              return
> > -        keys.sort()
> >  
> >          if heading:
> >              print("%-30s %-18s %s\n" % (_("SELinux IB End Port Type"), _("IB Device Name"), _("Port Number")))
> > -        for i in keys:
> > +        for i in sorted(keys):
> >              rec = "%-30s %-18s " % i
> >              rec += "%s" % ddict[i][0]
> >              for p in ddict[i][1:]:
> > -- 
> > 2.9.4
> > 
> > 
> 
