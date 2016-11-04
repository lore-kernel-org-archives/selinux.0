Subject: Re: [PATCH] Revert "libselinux: support new python3 functions"
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <20161102152431.30464-1-bigon@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <49d3f921-1ef2-1045-bac5-6741a7e77c4f@tycho.nsa.gov>
Date: Fri, 4 Nov 2016 15:41:56 -0400
MIME-Version: 1.0
In-Reply-To: <20161102152431.30464-1-bigon@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/02/2016 11:24 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> With the reverted commit applied, some functions were returning arrays
> of bytes instead of python strings under python3 this was causing issues
> with string manipulation functions like split().
> 
> Swig (checked with 3.0.7) is adding compatibility macros that take care
> of the differences between python2 and python3.
> 
> This reverts commit 63df0f7ef12844b9b86cc293299671da772fcf84.

Thanks, applied

> 
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> ---
>  libselinux/src/selinuxswig_python.i | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
> index 8cea18d..43df291 100644
> --- a/libselinux/src/selinuxswig_python.i
> +++ b/libselinux/src/selinuxswig_python.i
> @@ -64,7 +64,7 @@ def install(src, dest):
>  	PyObject* list = PyList_New(*$2);
>  	int i;
>  	for (i = 0; i < *$2; i++) {
> -		PyList_SetItem(list, i, PyBytes_FromString((*$1)[i]));
> +		PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
>  	}
>  	$result = SWIG_Python_AppendOutput($result, list);
>  }
> @@ -97,9 +97,7 @@ def install(src, dest):
>  			len++;
>  		plist = PyList_New(len);
>  		for (i = 0; i < len; i++) {
> -			PyList_SetItem(plist, i,
> -                                       PyBytes_FromString((*$1)[i])
> -                                       );
> +			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
>  		}
>  	} else {
>  		plist = PyList_New(0);
> @@ -116,9 +114,7 @@ def install(src, dest):
>  	if (*$1) {
>  		plist = PyList_New(result);
>  		for (i = 0; i < result; i++) {
> -			PyList_SetItem(plist, i,
> -                                       PyBytes_FromString((*$1)[i])
> -                                       );
> +			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
>  		}
>  	} else {
>  		plist = PyList_New(0);
> @@ -171,20 +167,16 @@ def install(src, dest):
>  	$1 = (char**) malloc(size + 1);
>  
>  	for(i = 0; i < size; i++) {
> -		if (!PyBytes_Check(PySequence_GetItem($input, i))) {
> -			PyErr_SetString(PyExc_ValueError, "Sequence must contain only bytes");
> -
> +		if (!PyString_Check(PySequence_GetItem($input, i))) {
> +			PyErr_SetString(PyExc_ValueError, "Sequence must contain only strings");
>  			return NULL;
>  		}
> -
>  	}
>  		
>  	for(i = 0; i < size; i++) {
>  		s = PySequence_GetItem($input, i);
> -
> -		$1[i] = (char*) malloc(PyBytes_Size(s) + 1);
> -		strcpy($1[i], PyBytes_AsString(s));
> -
> +		$1[i] = (char*) malloc(PyString_Size(s) + 1);
> +		strcpy($1[i], PyString_AsString(s));
>  	}
>  	$1[size] = NULL;
>  }
> 
