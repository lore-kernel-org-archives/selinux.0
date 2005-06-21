Message-ID: <42B8A699.206@tresys.com>
Date: Tue, 21 Jun 2005 19:45:29 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: alexander-barclay@utulsa.edu, Brandon Pollet <brandon@utulsa.edu>,
   SELinux@tycho.nsa.gov, John Hale <john-hale@utulsa.edu>
Subject: Re: XML Based Policy Configuration for SELinux
References: <7D1D591C-7CB7-4FAA-82DF-0CA87BE3372F@utulsa.edu> <20050621184940.GA8354@lkcl.net> <1119383982.42b871aef1898@cc.utulsa.edu> <20050621212059.GA9434@lkcl.net>
In-Reply-To: <20050621212059.GA9434@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>On Tue, Jun 21, 2005 at 02:59:42PM -0500, alexander-barclay@utulsa.edu wrote:
>  
>
> <snip>
>
> it is not a worst-case scenario: the policy.conf file is completely
> _useless_ on its own as it only makes sense in combination with
> file_contexts and the tunables (i might have missed something else
> out... hmmm)
>  
>
This isn't true, apol, and probably other tools, read policy.conf for 
doing policy analysis.

> policy.conf is an "intermediary": do not be deceived by it being in a
> readable flat file format!
>
sure but it also contains all the information you need to see how the 
loaded policy will work

><snip>
>
> - 1) policy.conf + file_contexts + tunables
> - 2) policy.NN + file_contexts + tunables
> - 3) /etc/selinux/src/* (*.te, *.fc, users, mls, rpac, net_contexts etc) +
>      tunables
>  
>
tunables will be part of the language once the modules are in use and 
therefore will be preserved in the binary module format

><snip>
>  
>
> which are actually quite difficult - if not impossible - to
> "extract" from the policy.conf file, in isolation, with no
> access to the "users" file.
>
>  
>
that is precisely what all the analysis do

> basically, policy.conf and file_contexts do not provide the "full
> picture" that would make the representation of selinux policy in XML
> file format "useful" to developers and sysadmins.
>  
>
file_contexts are an initial configuration and not necessarilly as 
interesting as the actual filesystem contexts

> wish list item 1):
>
> * the ability to read /etc/selinux/src/* (*.te, *.fc, users,
>   mls, rpac, net_contexts etc) + tunables into an XML formatted file
>
>  
>

Why? XML's only purpose in life is to transform from a generalized 
format to some other format, mostly for human consumption. Having the 
rules themselves in XML does very little in the way of making the policy 
easier to read (or rather detracts from that) and you'd just have to 
convert it to the existing format anyway. The XML in the reference 
policy is for documentation only, and is used to convert from the inline 
docs to html, text, possibly man pages and so on, it is not meant to be 
read directly.

>   whilst still recognising that certain areas of the policy are to do
>   with certain programs / services.
>
>   i.e. reflecting the directory "domains" and the individual files _in_
>   domains in the tree structure of the XML document.  i.e. giving
>   apache.te its own "node" hierarchy as distinct and completely
>   separate from "src/domains//misc/kernel.te".
>
>  
>
Thats what the type hierarchy patch we sent a while back is suppose to 
do. So you make an "apache" type and then children types that are 
constrained by the permissions of apache. This is a compiler and 
infrastructure enforced constraint that is very useful for doing things 
such as delegating access to parts of the policy and ensuring it doesn't 
exceed the original permissions granted.

> wish list item 2)
>
> * the ability to output /etc/selinux/src/* (*.te, *.fc, users,
>   mls, rpac, net_contexts etc) + tunables etc from an XML
>   formatted file.
> 
> _that's_ useful.
>  
>
How is it useful exactly? what would the XML be used for? converting 
something to XML for the sake of doing so doesn't really accomplish 
anything.

Joshua Brindle
Tresys Technology

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
