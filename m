Subject: Re: Android checkpolicy crash
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC5601042D91@ORSMSX103.amr.corp.intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55BB6D6F.2070104@tycho.nsa.gov>
Date: Fri, 31 Jul 2015 08:43:27 -0400
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5601042D91@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/29/2015 08:11 PM, Roberts, William C wrote:
> I was investigating to see if we could start using
> file_type_auto_trans() for named file transitions, however the macro
> didn’t support passing name.
> 
> I have this hack’d up diff on the AOSP master branch (see attached
> patch.diff) that does it however is able to somehow trigger a
> checkpolicy crash
> 
>  
> 
> It dies on this line in the attached policy.conf:
> 
> type_transition system_server system_data_file:{ file lnk_file sock_file
> fifo_file } system_ndebug_socket "ndebugsocket";
> 
>  
> 
> When you drop that line to a single class it works fine:
> 
> type_transition system_server system_data_file:sock_file
> system_ndebug_socket "ndebugsocket";
> 
>  
> 
> Valgrind reports some invalid free’s and memory accesses, see attached
> valgrind.log.

So this is a bug (pointer aliasing in define_filename_trans() in
checkpolicy; need to copy the type sets for each class when creating the
rules), but I don't think you want to do this regardless.  You always
want to be specific about the class when writing a name-based
transition, and you don't want to generate a bunch of dead rules that
will never be used.  file_type_trans()/file_type_auto_trans() in Android
policy is only really useful if you truly want it applied to all
classes, unless we change it to take an argument to specify the target
classes (this is what is done in refpolicy, in filetrans_pattern()).
