Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k19KhkXf029720
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 15:43:46 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k19KgR7q003192
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 20:42:27 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k19Khjsm028078
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 15:43:45 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k19KhZ111622
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 15:43:35 -0500
Received: from [172.16.50.2] (vpn50-2.rdu.redhat.com [172.16.50.2])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id k19KhYQo013165
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 15:43:34 -0500
Message-ID: <43EBA990.50900@redhat.com>
Date: Thu, 09 Feb 2006 15:44:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: audit2ref helpful tool for writing some reference policy
Content-Type: multipart/mixed;
 boundary="------------070107020308080203000804"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070107020308080203000804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Little tool to search reference policy to match audit2allow rule

Reads stdin and attempts to find matches in reference policy for allow 
rules.

audit2allow -i /var/log/audit/audit.log | python audit2ref

Problem right now is it comes up with two many matches, sometimes misses 
altogether.

Useful experiment with Awk and regular expressions.

 echo "allow abx_t httpd_log_t:file read;" | python audit2ref
# Replace next allow rule with one of the following
# allow abx_t httpd_log_t:file read

gen_require(`apache', `
        apache_read_log(abx_t)
')

echo "allow abx_t var_log_t:file read;" | python audit2ref
# Replace next allow rule with one of the following
# allow abx_t var_log_t:file read

gen_require(`logging', `
        logging_read_generic_logs(abx_t)
        logging_write_generic_logs(abx_t)
        logging_rw_generic_logs(abx_t)
        logging_manage_generic_logs(abx_t)
')

 echo "allow abx_t avahi_exec_t:file execute;" | python audit2ref
allow abx_t avahi_exec_t:file execute


--------------070107020308080203000804
Content-Type: text/plain;
 name="audit2ref"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit2ref"

import sys, commands, os, re

obj="(\{[^\}]*\}|[^ \t:]*)"
allow_regexp="allow[ \t]+%s[ \t]*%s[ \t]*:[ \t]*%s[ \t]*%s" % (obj, obj, obj, obj)

class accessTrans:
    def __init__(self):
        self.dict={}
        fd=open("/usr/share/selinux/refpolicy/include/obj_perm_sets.spt")
        records=fd.read().split("\n")
        regexp="^define *\(`([^']*)' *, *` *\{([^}]*)}'"
        for r in records:
            m=re.match(regexp,r)
            if m!=None:
                self.dict[m.groups()[0]] = m.groups()[1].split()
        fd.close()
    def get(self, var):
        l=[]
        for v in var:
            if v in self.dict.keys():
                l += self.dict[v]
            else:
                if v not in ("{", "}"):
                    l.append(v)
        return l

class interfaces:
    def __init__(self):
        self.dict={}
        trans=accessTrans()
        awk_file="extract-interface.awk"
        if os.path.exists(awk_file):
            rc=commands.getstatusoutput("awk -f %s /usr/share/selinux/refpolicy/include/*.if" % awk_file) 
        else:
            rc=commands.getstatusoutput("awk -f /usr/share/selinux/refpolicy/%s /usr/share/selinux/refpolicy/include/*.if" % awk_file)
        if rc[0] == 0:
            regexp="([^ \t]*)[ \t]+([^ \t]*)[ \t]+%s" % allow_regexp
            records=rc[1].split("\n")
            for r in records:
                m=re.match(regexp,r)
                if m==None:
                    continue
                else:
                    val=m.groups()
                file=os.path.basename(val[0]).split(".")[0]
                iface=val[1]
                Scon=val[2].split()
                Tcon=val[3].split()
                Class=val[4].split()
                Access=trans.get(val[5].split())
                for s in Scon:
                    for t in Tcon:
                        for c in Class:
                            if (s, t, c) not in self.dict.keys():
                                self.dict[(s, t, c)]=[]
                            self.dict[(s, t, c)].append((Access, file, iface))
    def out(self):
        keys=self.dict.keys()
        keys.sort()
        for k in keys:
            print k
            for i in self.dict[k]:
                print "\t", i
                
    def match(self, Scon, Tcon, Class, Access):
        keys=self.dict.keys()
        if (Scon, Tcon, Class) in keys:
            return self.dict[(Scon, Tcon, Class)]
        if ("$1", Tcon, Class) in keys:
            return self.dict[("$1", Tcon, Class)]
        if (Scon, "$1", Class) in keys:
            return self.dict[("$1", Tcon, Class)]
        else:
            return None
        
iface=interfaces()
dict={}
dict["__allow_rules__"]=[]
rec=sys.stdin.readline()
while len(rec):
	r=rec.strip(";\n")
        m=re.match(allow_regexp,r)
        if m==None:
            continue
        else:
            val=m.groups()
        Scon=val[0]
        Tcon=val[1]
        Class=val[2]
        Access=val[3]
        m=iface.match(Scon,Tcon,Class,Access)
        if m == None:
            print  r
        else:
            file=m[0][1]
            print"# Replace next allow rule with one of the following\n# %s "% r
            print "\ngen_require(`%s', `" % m[0][1]
            for i in m:
                if file != i[1]:
                    print "')\ngen_require(`%s', `" % i[1]
                    file = i[1]
                print "\t%s(%s)" % (i[2], Scon)
            print "')"

	rec=sys.stdin.readline()


--------------070107020308080203000804
Content-Type: text/plain;
 name="extract-interface.awk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="extract-interface.awk"

/^[[:blank:]]*interface[[:blank:]]*\(/ {
        IFACEFILE=FILENAME
	IFACENAME = gensub("^[[:blank:]]*interface[[:blank:]]*\\(`?","","g",$0);
	IFACENAME = gensub("'?,.*$","","g",IFACENAME);
}

/^[[:blank:]]*allow[[:blank:]]+.*;[[:blank:]]*$/ {

  if ((length(IFACENAME) > 0) && (IFACEFILE == FILENAME)){
		ALLOW = gensub("^[[:blank:]]*","","g",$0)
		ALLOW = gensub(";[[:blank:]]*$","","g",$0)
		print FILENAME "\t" IFACENAME "\t" ALLOW;
	}
}

--------------070107020308080203000804--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
