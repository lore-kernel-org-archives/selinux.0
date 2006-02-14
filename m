Subject: Re: Improve bindings, add PyList(String) for roles array
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43F226B5.6020603@cornell.edu>
References: <43E26F62.7010400@cornell.edu> <43F1B827.401@cornell.edu>
	 <43F1C84C.5030800@cornell.edu>  <43F226B5.6020603@cornell.edu>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 15:12:36 -0500
Message-Id: <1139947956.14253.313.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-14 at 13:51 -0500, Ivan Gyurdiev wrote:
> ChangeLog:
> 
> - Split out PyList building code and put it in a common function. In 
> that function:
>    - audit failure in PyNew
>    - audit failure in PyAppend (used to be SetItem)
>    - audit failure in SWIG_NewPointerObj
>    - on failure, call the object destructor function on the entire list, 
> and return STATUS_ERR.
> 
>    I'm not sure if that accomplishes much. I suspect the swig wrappers 
> have a million ways in which they can fail internally. Yet, I feel like 
> it is wrong to not audit errors in code that I write, so this corrects 
> that mistake. I also like the idea of the list building code being in a 
> common function.
> 
> - Add more PyLists..... convert semanage_user_get_roles() to using 
> PyList, instead of character arrays.
>     - Remove char_by_idx.
>     - fix dependency in seobject.py
>     - unlike other wrappers, this one also converts the string itself, 
> from char* to a python string
>       (see semanage2plist, which can be called in two ways)
> 
> - Use fewer SWIG internal conventions
>      - don't use the result variable - use the $result python variable, 
> which is documented. Use SWIG_As_int to get the integer out of it.
>      - do not use SWIGTYPE_...* where possible. Use special variables 
> that provide access to the descriptor without writing out the type.

Merged as of libsemanage 1.5.25 and policycoreutils 1.29.25.

> Next:
> - make the opposite conversion, and make set_roles() work properly
> - try to get rid of usage of t_output_helper()

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
