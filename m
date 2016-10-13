Subject: Re: speeding up nodups_specs, need large fc file.
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC561CD17F73@ORSMSX103.amr.corp.intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <191f635c-992e-c7bb-e74d-afb5966b4f89@tycho.nsa.gov>
Date: Thu, 13 Oct 2016 16:37:35 -0400
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC561CD17F73@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/13/2016 03:28 PM, Roberts, William C wrote:
> I was looking back at my speedup patch for nodups specs…
> 
> http://marc.info/?l=selinux&m=147249024230263&w=2
> 
>  
> 
> I was testing before with a large, generated file_context file. I was
> wondering what would be a good source for
> 
> A desktop version of a file_contexts (textual preference as I can run
> sefcontext_compile on it) file as well as a binary
> 
> policy file….
> 
>  
> 
> Should I just use refpolicy?

That's probably fine, unless you happen to have Fedora installed and can
just use its file_contexts file.

$ cd refpolicy
$ make MONOLITHIC=y conf
$ make MONOLITHIC=y file_contexts
$ wc -l file_contexts
4908 file_contexts
$ wc -l /etc/selinux/targeted/contexts/files/file_contexts
6075 /etc/selinux/targeted/contexts/files/file_contexts
