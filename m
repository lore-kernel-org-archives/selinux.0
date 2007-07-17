Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HKmVwN028975
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 16:48:31 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l6HKmUTM000359
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 20:48:30 GMT
Message-ID: <469D2B08.8010502@manicmethod.com>
Date: Tue, 17 Jul 2007 16:48:08 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [POLICYREP] [RFC/PATCH 2/3] policy package implementation
References: <20070717150336.135143158@manicmethod.com>	 <20070717150431.660417962@manicmethod.com>	 <1184686730.3833.11.camel@localhost.localdomain>	 <469CF0EC.8030704@manicmethod.com> <1184697355.3833.28.camel@localhost.localdomain>
In-Reply-To: <1184697355.3833.28.camel@localhost.localdomain>
Content-Type: text/html; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Karl MacMillan wrote:
<blockquote cite="mid:1184697355.3833.28.camel@localhost.localdomain"
 type="cite">
  <pre wrap="">On Tue, 2007-07-17 at 12:40 -0400, Joshua Brindle wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Karl MacMillan wrote:
    </pre>
  </blockquote>
  <pre wrap=""><!---->[...]
  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">+			// Currently we use the name of the file to decide what kind of file it is
+			// I am fairly uncomfortable with this but it allows us to use xar to create
+			// policy packages instead of having our own write_package function that 
+			// assigns attributes to files instead of using names. 
    
        </pre>
      </blockquote>
      <pre wrap="">I don't like this either - what is the alternative?

  
      </pre>
    </blockquote>
    <pre wrap="">Ok, xar has an XML ToC for the file. It also provides an API to set 
arbitrary attributes for each file, so I can do something like 
selinuxfiletype = netfilter_contexts. This means that we would not be 
able to use the command line xar to create packages (I was trying to 
make this as simple as possible). If we move to using attributes we'd 
have to have a custom packager again (ala semodule_package).

    </pre>
  </blockquote>
  <pre wrap=""><!---->
It would be simpler though, correct? And what about an unpackager?
  </pre>
</blockquote>
<br>
Simpler in what way? This first patch I was trying to keep it dead
simple by not even requiring a custom packager and instead just using
xar CLI. If we want to use more sophisticated things in xar (like
per-file attributes) we'd need something custom. Even if we just make a
subdocument (which is archive-wide in scope) and add some selinux bits
to it like policy name that can still be done with the CLI.<br>
<br>
xar -xf foo.xar will unpackage it<br>
<blockquote cite="mid:1184697355.3833.28.camel@localhost.localdomain"
 type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">A custom packager has advantages, we can basically ensure that the 
package is sane (doesn't have directory trees or multiple 
&lt;something&gt;.netfilter_contexts files, etc. We can also add new 
properties such as the policy name to the xar XML subdocument.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
That sounds better than relying on file extension to me.

  </pre>
</blockquote>
<br>
agreed.<br>
<br>
<blockquote cite="mid:1184697355.3833.28.camel@localhost.localdomain"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">+			ret = xar_prop_get(f, "name", &amp;filename);
+			if (ret) {
+				xar_close(x);
+				throw "Error getting name property of file";
    
        </pre>
      </blockquote>
      <pre wrap="">Please define an exception.

  
      </pre>
    </blockquote>
    <pre wrap="">Why?

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Because none of the standard exception types seemed to fit and string
exceptions are not a good idea.

  </pre>
</blockquote>
<br>
So I can do both to get a specific error out instead of one that could
mean any of the files were duplicated, for example.<br>
<br>
<blockquote cite="mid:1184697355.3833.28.camel@localhost.localdomain"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">+			}
+			if (strstr(filename, ".mod")) {
+				// found module, do stuff
    
        </pre>
      </blockquote>
      <pre wrap="">Err - "do stuff"?

  
      </pre>
    </blockquote>
    <pre wrap="">There is no module_read function right now so thats just a placeholder.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
There is if the module is source :)

  </pre>
</blockquote>
<br>
nak.<br>
<blockquote cite="mid:1184697355.3833.28.camel@localhost.localdomain"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">+			} else if (strstr(filename, ".file_contexts")) {
+				if (!impl-&gt;file_contexts.empty()) {
+					// Found more than one file containing in .file_contexts,
+					// don't know how to handle that so bail for now
+					xar_close(x);
+					throw "Multiple file_contexts files in policy package";
+				}
+				impl-&gt;file_contexts = std::string(fbuf);
+			} else if (strstr(filename, ".seusers")) {
+				if (!impl-&gt;seusers.empty()) {
+					// Found more than one file containing in .seusers,
+					// don't know how to handle that so bail for now
+					xar_close(x);
+					throw "Multiple seusers files in policy package";
+				}
+				impl-&gt;seusers = std::string(fbuf);
    
        </pre>
      </blockquote>
      <pre wrap="">As we discussed privately - these copies are not great. Perhaps just use
raw char*.

  
      </pre>
    </blockquote>
    <pre wrap="">Ok, I don't know if this code is ever going to do anything with those 
and was trying to keep it in a format that would be more accessible if 
we needed to. I can change to char * though and see if anything develops 
that makes std::string make more sense.

    </pre>
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">+			} else if (strstr(filename, ".user_extra")) {
+				if (!impl-&gt;user_extra.empty()) {
+					// Found more than one file containing in .user_extra,
+					// don't know how to handle that so bail for now
+					xar_close(x);
+					throw "Multiple user_extra files in policy package";
+				}
+				impl-&gt;user_extra = std::string(fbuf);
+			} else if (strstr(filename, ".netfilter_contexts")) {
+				if (!impl-&gt;netfilter_contexts.empty()) {
+					// Found more than one file containing in .netfilter_contexts,
+					// don't know how to handle that so bail for now
+					xar_close(x);
+					throw "Multiple netfilter_contexts files in policy package";
+				}
+				impl-&gt;netfilter_contexts = std::string(fbuf);
+			} else {
+				// unrecognized file, just skip it
+				continue;
+			}
+
+		}
+
+		xar_close(x);
+
+		return 0;
+	}
+
+	PolicyPackage::PolicyPackage() {
+		init();
+	}
+
+	PolicyPackage::PolicyPackage(std::string filename) {
+		init();
+		read_package(filename);
+	}
+
+	PolicyPackage::~PolicyPackage() { delete impl; }
+
+	const Module PolicyPackage::get_policy_module() const {
+		return impl-&gt;policy_module;
+	}
    
        </pre>
      </blockquote>
      <pre wrap="">This should definitely not be by value. It should also likely not be
const - this is how the user will retrieve the module after reading to
use, correct? Then it shouldn't be const (they might want to much with
it), should be a reference, and shouldn't be const for the class (as
allowing users to change the module changes the object).

  
      </pre>
    </blockquote>
    <pre wrap="">Fair enough. I was basically thinking users would read a module and make 
their own copies (eg., copying the data into a merged copy or something) 
but that isn't really how policyrep works so I'll change all these to be 
non-const.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
One other note - if the caller is expected to take ownership for the
lifetime of the object (which seems possible), then it should return a
pointer or a shared_ptr.

  </pre>
</blockquote>
<br>
ok?<br>
</body>
</html>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
