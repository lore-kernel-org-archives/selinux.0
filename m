Subject: Re: [SEMANAGE] Seuser mls validation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, dwalsh@redhat.com
In-Reply-To: <43BA498C.60102@cornell.edu>
References: <43BA42A6.5020609@cornell.edu>  <43BA498C.60102@cornell.edu>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 08:48:38 -0500
Message-Id: <1136382518.27632.221.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-03 at 04:53 -0500, Ivan Gyurdiev wrote:
> > diff -Naurp --exclude-from excludes old/policycoreutils/semanage/semanage new/policycoreutils/semanage/semanage
> > --- old/policycoreutils/semanage/semanage	2006-01-01 06:17:40.000000000 -0500
> > +++ new/policycoreutils/semanage/semanage	2005-12-26 21:50:33.000000000 -0500
> > @@ -109,8 +109,6 @@ class seluserRecords:
> >  		semanage_user_add_local(self.sh, k, u)
> >  		if semanage_commit(self.sh) != 0:
> >  			raise ValueError("Failed to add SELinux user")
> > -
> > -		self.dict[name]=seluser(name, roles, selevel, serange)
> >  		
> >  	def modify(self, name, roles=[], selevel="", serange=""):
> >  		(rc,k)=semanage_user_key_create(self.sh, name)
> > @@ -164,7 +162,6 @@ class seluserRecords:
> >  
> >  class portRecords:
> >  	def __init__(self):
> > -		self.dict={}
> >  		self.sh=semanage_handle_create()
> >  		self.semanaged=semanage_is_managed(self.sh)
> >  		if self.semanaged:
> > @@ -209,11 +206,19 @@ class portRecords:
> >  		
> >  	def list(self):
> >  		(status, self.plist, self.psize) = semanage_port_list(self.sh)
> > -		print "%-25s %s\n" % ("SELinux Port Name", "Port Number")
> > +		print "%-15s %-25s\n" % ("Port Range", "Context")
> >  		for idx in range(self.psize):
> > -			u=semanage_port_by_idx(self.plist, idx)
> > -			name=semanage_port_get_name(u)
> > -			print "%20s %d" % ( name, semanage_port_get_number(u))
> > +			p=semanage_port_by_idx(self.plist, idx)
> > +			low = semanage_port_get_low(p)
> > +			high = semanage_port_get_high(p)
> > +			proto_str = semanage_port_get_proto_str(p)
> > +			if low == high:
> > +				range_str = str(low)
> > +			else:
> > +				range_str = str(low) + ":" + str(high)
> > +			con = semanage_port_get_con(p)
> > +			(rc,con_str) = semanage_context_to_string(self.sh, con)
> > +			print "%-10s%-5s %-25s" % (range_str, proto_str, con_str)
> >  			
> >  if __name__ == '__main__':
> >  
> >   
> Okay, that last part snuck in by accident, I had been deleting it from 
> the patch for a while, and I finally missed it. Let me know if you want 
> a new patch - this shouldn't do any harm with the ports merged, I think 
> it's correct. Does not check the rc values, but neither does the rest of 
> that tool. At least it doesn't run user code for ports, like the current 
> implementation does.
> 
> ...or just delete it if you want, Dan might have an alternative 
> implementation.

Is the semanage diff here obsoleted by Dan's latest policycoreutils
patch?  Also, the first hunk looks odd to me - what is it doing?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
