Subject: Re: [SEMANAGE][UTILS] Use PyList in bindings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43E26F62.7010400@cornell.edu>
References: <43E26F62.7010400@cornell.edu>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 09:00:32 -0500
Message-Id: <1138975232.18268.362.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-02 at 15:45 -0500, Ivan Gyurdiev wrote:
> Okay, this patch is being the subject of controversy on IRC, so I wanted 
> to continue discussion on-list.
> 
> It's an API change in the python bindings only, which converts out-bound 
> arrays of objects (port, iface, boolean, etc..) to a PyList, which makes 
> them easier to work with, and better integrated with the target 
> language. Also, it fixes memory leak of the list structure (otherwise we 
> have to expose free() to address that). It eliminates the need for 
> get_by_idx functions, which are not really part of the libsemanage API.
> 
> Some problems w/ patch - it relies on some internal swig things - like 
> the output variable being called result (swig provides $result, but 
> that's in python, and I don't want to unpack it). Not sure if that's a 
> problem, I'm not sure this t_output_helper business is part of the 
> official API either. Also, swig is not very intelligent, and wants all 
> the argument names to match (despite the docs saying otherwise).
> 
> Joshua doesn't like it..says semanage.i should be portable to other 
> languages. However, I like better integration w/ python, so I think in 
> that case maybe it makes sense to have several .i files. Also, I'm not 
> sure the .i file is language portable right now - what will happen in a 
> language that doesn't support an output vector, so adding things to 
> result w/ t_output_helper doesn't necessarily make sense?
> 
> Also, how do I implement a binding for set_roles()? I want to unpack a 
> PyList into a char** array - requires understanding of python in the .i 
> file.

Abstractly (while confessing total ignorance of swig), I would agree
that we shouldn't cripple the python bindings for libsemanage just to
allow a single interface file to be re-useable for other bindings.  That
said, I'm a little hesitant to merge without greater consensus and FC5
is very close to devel freeze.  Not sure what expectations are for
stability of python bindings API...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
