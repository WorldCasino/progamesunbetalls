﻿//------------------------------------------------------------------------------
// <autogenerated>
//     This code was generated by a CodeSmith Template.
//
//     DO NOT MODIFY contents of this file. Changes to this
//     file will be lost if the code is regenerated.
//     Author:Yubao Li
// </autogenerated>
//------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Text;

namespace OpenAuth.Domain
{
    /// <summary>
	/// 数据字典
	/// </summary>
    public partial class DicIndex
    {
        public DicIndex()
        {
          this.Id= 0;
          this.Name= string.Empty;
          this.Key= string.Empty;
          this.SortNo= 0;
          this.CategoryId= 0;
          this.Description= string.Empty;
        }

        /// <summary>
	    /// 数据字典ID
	    /// </summary>
        public int Id { get; set; }
        /// <summary>
	    /// 名称
	    /// </summary>
        public string Name { get; set; }
        /// <summary>
	    /// 
	    /// </summary>
        public string Key { get; set; }
        /// <summary>
	    /// 排序号
	    /// </summary>
        public int SortNo { get; set; }
        /// <summary>
	    /// 所属分类
	    /// </summary>
        public int CategoryId { get; set; }
        /// <summary>
	    /// 描述
	    /// </summary>
        public string Description { get; set; }

    }
}